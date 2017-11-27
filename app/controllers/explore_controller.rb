class ExploreController < ApplicationController

  before_action :authenticate_user!

  def index
    @all_areas = AreaDeInteresse.where(name: ["Engenharias", "Marketing", "Administração"])

    if params and params[:areas_interesse].present?
      @selected_areas = AreaDeInteresse.where(id: params[:areas_interesse].map { |item| item.to_i})
    else
      @selected_areas = AreaDeInteresse.where(name: ["Engenharias", "Marketing", "Administração"])
    end

    @avaliable_projects = current_user.available_projects(@selected_areas.map { |item| item.id})
  end
end