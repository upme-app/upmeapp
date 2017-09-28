class AdminProjectsController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_admin

  def index

  end

  def show
    @project = Project.find(params[:id])
  end

end
