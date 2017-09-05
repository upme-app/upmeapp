class ProjectsController < ApplicationController

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render 'projects/new'
    end
  end

  def show

  end

  def show_public
    set_project
  end

  def view
  end

  private

  def project_params
    params.require(:project).permit(:title, :objective, :description, :nat_privada, :nat_publica, :nat_ong)
  end

  def set_project
    @project = Project.find(params[:id])
  end
end
