class ProjectsInvitationController < ApplicationController


  def accept_invitation
    set_invitation
    flash[:success] = 'Você entrou no projeto!'
    redirect_to project_path(@invitation.id)
  end

  def refuse_invitation
    set_invitation
    flash[:success] = 'Convite recusado!'
    @invitation.destroy
    redirect_to projects_path
  end

  private

  def set_invitation
    @invitation = ProjectInvitation.find(params[:invitation_id])
    @invitation = nil if @invitation.user_to_id != current_user.id
  end

end
