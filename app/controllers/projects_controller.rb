class ProjectsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_project, except: [:show_public, :index, :new, :create]

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

  def show
    set_project
  end

  def invitations
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

  def create_invitation
    set_project

    user_to = User.find_by_email(params[:email])

    if user_to and !@project.has_user(user_to)
      @invitation = ProjectInvitation.new({
        user_from_id: current_user.id,
        user_to_id: user_to.id,
        project_id: @project.id
      })
      if @invitation.save
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

    @solicitation = ClientSolicitation.new({
      user_id: current_user.id,
      project_id: @project.id,
      message: params[:message]
    })

    if @solicitation.save
      flash[:success] = 'Solicitação enviada!'
    else
      flash[:danger] = 'Erro!'
    end

    redirect_to public_project_path(@project.id)
  end

  private

  def project_params
    params.require(:project).permit(:title, :objective, :description, :nat_privada, :nat_publica, :nat_ong)
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
