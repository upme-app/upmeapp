class ExploreController < ApplicationController

  before_action :authenticate_user!

  def index
    @all_areas = AreaDeInteresse.all
    @selected_areas = @all_areas

    if params and params[:areas_interesse].present?
      @selected_areas = AreaDeInteresse.where(id: params[:areas_interesse].map { |item| item.to_i})
    end

    @avaliable_projects = current_user.available_projects
  end
end
