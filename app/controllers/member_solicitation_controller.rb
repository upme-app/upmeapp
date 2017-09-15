class MemberSolicitationController < ApplicationController

  before_action :authenticate_user!, :set_solicitation

  def accept
    project_id = @solicitation.project_id
    @solicitation.accept(current_user)
    flash[:success] = 'Solicitação de membro aceita.'
    redirect_to member_solicitations_path(project_id)
  end

  def refuse
    project_id = @solicitation.project_id
    @solicitation.refuse(current_user)
    flash[:success] = 'Solicitação de membro recusada.'
    redirect_to member_solicitations_path(project_id)
  end

  private

  def set_solicitation
    @solicitation = MemberSolicitation.find(params[:solicitation_id])
  end

end
