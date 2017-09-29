class ProjectsController < ApplicationController

  before_action :authenticate_user!
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
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if @project.save
      redirect_to project_path(@project)
    else
      render 'projects/new'
    end
  end

  def edit
    set_project
  end

  def update
    set_project
    if @project.update_attributes(project_params)
      redirect_to project_path(@project)
    else
      render 'projects/edit'
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

    project_user = ProjectUser.where(project_id: @project.id).where(user_id: current_user.id).first
    unless project_user.first_timeline_view == true
      project_user.update_attribute :first_timeline_view, true
    end

  end

  def timeline_comment
    set_project
    @step = TimelineStep.find(params[:timeline_step_id])

    if current_user.can_timeline_comment?(@project, @step)
      TimelineComment.create({
                                 message: params[:message],
                                 timeline_step_id: @step.id,
                                 user_id: current_user.id
                             })
      flash[:notice] = 'Comentário enviado.'
    end

    redirect_to timeline_path(@project.id)
  end

  def show_public
    set_project
  end

  def view
  end

  def invite_user_to_project
    set_project

    user_to = User.find_by_email(params[:email])

    if user_to and !@project.has_user(user_to)
      @invitation = ProjectInvitation.new({
        user_from_id: current_user.id,
        user_to_id: user_to.id,
        project_id: @project.id
      })
      if @invitation.save
        Thread.new {ProjectInvitationMailer.invite(@invitation.user_to, @invitation.user_from, @project).deliver }
        flash[:success] = 'Solicitação enviada!'
      else
        flash[:danger] = 'Erro!'
      end
    else
      flash[:danger] = 'Email não cadastrado.'
    end

    redirect_back(fallback_location: project_path(@project.id))
  end

  def add_client_solicitation
    set_project
    @solicitation = ClientSolicitation.new_solicitation(current_user, @project, params[:message])

    if @solicitation.save
      Thread.new { ClientSolicitationMailer.invite(current_user, @project.user, @project).deliver }
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
      Thread.new { MemberSolicitationMailer.invite(current_user, @project.user, @project).deliver }
      flash[:success] = 'Solicitação enviada!'
    else
      flash[:danger] = 'Erro!'
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

end
