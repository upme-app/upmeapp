class ProjectsInvitationController < ApplicationController
  before_action :authenticate_user!

  def accept_invitation
    set_invitation
    flash[:success] = 'Você entrou no projeto!'
    @invitation.accept_and_notify
    redirect_to negotiation_path(@invitation.project_id)
  end

  def refuse_invitation
    set_invitation
    flash[:success] = 'Convite recusado!'
    @invitation.refuse_and_notify
    redirect_to projects_path
  end

  private

  def set_invitation
    @invitation = ProjectInvitation.find(params[:invitation_id])
    @invitation = nil if @invitation.user_to_id != current_user.id
  end
end
