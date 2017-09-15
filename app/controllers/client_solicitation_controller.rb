class ClientSolicitationController < ApplicationController

  before_action :authenticate_user!, :set_solicitation

  def accept
    project_id = @solicitation.project_id
    @solicitation.accept(current_user)
    flash[:success] = 'Solicitação de cliente aceita.'
    redirect_to timeline_path(project_id)
  end

  def refuse
    project_id = @solicitation.project_id
    @solicitation.refuse(current_user)
    flash[:success] = 'Solicitação de cliente recusada.'
    redirect_to client_solicitations_path(project_id)
  end

  private

  def set_solicitation
    @solicitation = ClientSolicitation.find(params[:solicitation_id])
  end


end
