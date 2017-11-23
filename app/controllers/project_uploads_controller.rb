class ProjectUploadsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_project

  def index
  end

  private

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
