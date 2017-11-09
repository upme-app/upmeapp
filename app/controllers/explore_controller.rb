class ExploreController < ApplicationController

  before_action :authenticate_user!

  def index
    @selected_areas = current_user.user_area_de_interesse.map(&:area_de_interesse).pluck(:name)
    if params[:areas]
      @selected_areas = AreaDeInteresse.where(name: params[:areas]).pluck(:name)
    end
  end


end
