class ProjectClientSolicitationController < ApplicationController

  before_action :authenticate_user!

  def accept_client_solicitation
    set_solicitation
    project_id = @solicitation.project_id
    if current_user.my_projects.pluck(:id).include? @solicitation.project_id
      @solicitation.project.update_attribute(:client_id, @solicitation.user_id)
      @solicitation.project.add_user(User.find(@solicitation.user_id))
      TimelineStep.init_project_steps(@solicitation.project)
      @solicitation.destroy
    end
    flash[:success] = 'Solicitação aceita.'
    redirect_to timeline_path(project_id)
  end

  def refuse_client_solicitation
    set_solicitation
    project_id = @solicitation.project_id
    if current_user.my_projects.pluck(:id).include? @solicitation.project_id
      @solicitation.destroy
    end
    flash[:success] = 'Solicitação recusada.'
    redirect_to invitations_path(project_id)
  end

  private

  def set_solicitation
    @solicitation = ClientSolicitation.find(params[:solicitation_id])
  end


end
