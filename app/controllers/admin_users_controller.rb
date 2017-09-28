class AdminUsersController < ApplicationController

  before_action :authenticate_user!
  before_action :authorize_admin

  def index

  end

  def show
    @user = User.find(params[:id])
  end

end
