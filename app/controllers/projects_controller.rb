class ProjectsController < ApplicationController

  before_action :authenticate_user!, except: [:show_public]
  before_action :authorize_project, except: [:show_public, :index, :filed_projects, :new, :create, :add_client_solicitation, :add_member_solicitation]


  def index
    @projects = current_user.my_projects
  end

  def filed_projects
    @projects = current_user.my_filed_projects
    render 'index'
  end

  def new
    @project = Project.new
    @selected_areas = []
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      save_areas_de_interesse
      redirect_to project_path(@project)
    else
      render 'projects/new'
    end
  end

  def edit
    set_project
    if current_user.can_edit_project? @project
      @selected_areas = AreaDeInteresse.where(id: @project.project_area_de_interesse.pluck(:area_de_interesse_id)).pluck(:name)
    else
      flash[:danger] = 'Você não pode acessar essa página'
      redirect_to public_project_path(@project.id)
    end
  end

  def update
    set_project
    if current_user.can_edit_project? @project
      if @project.user_id == current_user.id and @project.update_attributes(project_params)
        ProjectAreaDeInteresse.where(project_id: @project.id).delete_all
        save_areas_de_interesse
        redirect_to project_path(@project)
      else
        render 'projects/edit'
      end
    else
      flash[:danger] = 'Você não pode acessar essa página'
      redirect_to public_project_path(@project.id)
    end
  end

  def duplicate
    @duplicated_project = @project
    @project = Project.new
    @project.title = @duplicated_project.title
    @project.target_audience = @duplicated_project.target_audience
    @project.objective = @duplicated_project.objective
    @project.description = @duplicated_project.description
    @project.nat_privada = @duplicated_project.nat_privada
    @project.nat_publica = @duplicated_project.nat_publica
    @project.nat_ong = @duplicated_project.nat_ong
    render 'projects/new'
  end

  def show
    set_project
  end

  def client_solicitations
    set_project
  end

  def member_solicitations
    set_project
  end


  def timeline
    set_project
  end

  def events
    set_project
    @events = ProjectEvent.where(project_id:@project.id)
  end

  def payment
    @payments = Payment.all.where(user_id: current_user.id)
    set_project
  end

  def show_timeline
    set_project

    project_user = ProjectUser.where(project_id: @project.id).where(user_id: current_user.id).first
    unless project_user.first_timeline_view == true
      project_user.update_attribute :first_timeline_view, true
    end

    @selected_step = @project.timeline_steps.first.id
    @project.timeline_steps.order(entrega: :desc).each do |step|
      unless step.entregue?
        @selected_step = step.id
      end
    end

    render layout: false
  end

  def timeline_comment
    set_project
    @step = TimelineStep.find(params[:timeline_step_id])

    if current_user.can_timeline_comment?(@project, @step)
      @comment = TimelineComment.new({
                                 message: params[:message],
                                 timeline_step_id: @step.id,
                                 user_id: current_user.id
                             })

      if @comment.save
        @project.project_users.reject { |pu| pu.user.id == current_user.id }.each do |pu|
          TimelineMailer.comment(current_user, pu.user, @project).deliver_later
        end
      end
    end

    @selected_step = @step.id

    render :show_timeline, layout: false
  end

  def update_timeline_date
    set_project
    @step = TimelineStep.find(params[:step_id])

    if current_user.can_edit_step_entrega?(@project, @step) and @step.update_attribute(:entrega, params[:date])
      flash[:notice] = 'Data alterada!'
    else
      flash[:alert] = 'Erro!'
    end

    redirect_to timeline_path(@project)
  end

  def finish_step
    set_project
    @step = TimelineStep.find(params[:step_id])
    if @step.finish(current_user)
      flash[:notice] = 'Etapa entregue!'
    else
      flash[:alert] = 'Erro!'
    end
    redirect_to timeline_path(@project)
  end

  def show_public
    set_project
  end

  def view
  end

  def invite_user_to_project
    set_project

    result = @project.invite_email(params[:email], current_user)

    case result
      when :user_already_in_project
        flash[:danger] = 'Este usuário já é membro deste projeto.'
      when :success
        flash[:success] = 'Solicitação enviada!'
      when :already_sent
        flash[:danger] = 'Solicitação já foi enviada.'
      when :invalid_email
        flash[:danger] = 'Email inválido.'
      else
        flash[:danger] = 'Erro!'
    end

    redirect_back(fallback_location: project_path(@project.id))
  end

  def add_client_solicitation
    set_project
    @solicitation = ClientSolicitation.new_solicitation(current_user, @project, params[:message])

    if @solicitation.save
      ClientSolicitationMailer.invite(current_user, @project.user, @project).deliver_later
      Notification.invite_client_solicitation(current_user, @project.user, @project)
      flash[:success] = 'Solicitação enviada!'
    else
      flash[:danger] = 'Erro!'
    end
    redirect_to public_project_path(@project.id)
  end

  def add_member_solicitation
    set_project
    @solicitation = MemberSolicitation.new_solicitation(current_user, @project, params[:message])

    if @solicitation.save
      MemberSolicitationMailer.invite(current_user, @project.user, @project).deliver_later
      Notification.invite_member_solicitation(current_user, @project.user, @project)
      flash[:success] = 'Solicitação enviada!'
    else
      flash[:danger] = @solicitation.errors.full_messages.join(', ')
    end
    redirect_to public_project_path(@project.id)
  end

  def delete
    if @project.can_be_deleted_by(current_user)
      flash[:success] = 'Projeto excluído!'
      @project.update_attribute(:deleted, true)
    else
      flash[:danger] = 'Você não pode fazer isso.'
    end
    redirect_to project_path(@project.id)
  end

  def restore
    if @project.can_be_restored_by(current_user)
      flash[:success] = 'Projeto restaurado!'
      @project.update_attribute(:deleted, false)
    else
      flash[:danger] = 'Você não pode fazer isso.'
    end
    redirect_to project_path(@project.id)
  end

  private

  def project_params
    params.require(:project).permit(:title, :objective, :description, :target_audience, :nat_privada, :nat_publica, :nat_ong)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_project
    set_project
    unless @project.has_user(current_user)
      flash[:danger] = 'Você não pode acessar essa página'
      redirect_to public_project_path(@project.id)
    end
  end

  def save_areas_de_interesse
    params[:areas] = [] if params[:areas].nil?
    params[:areas].each do |nome_area|
      area_de_interesse = AreaDeInteresse.find_by_name(nome_area)
      if area_de_interesse
        ProjectAreaDeInteresse.create({project_id: @project.id, area_de_interesse_id: area_de_interesse.id})
      end
    end
  end
end
