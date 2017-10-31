class ExploreController < ApplicationController

  before_action :authenticate_user!

  def index
    @selected_areas = current_user.user_area_de_interesse.map(&:area_de_interesse).pluck(:name)
    if params[:areas]
      @selected_areas = AreaDeInteresse.where(name: params[:areas]).pluck(:name)
    end
  end

  def create_not_found_notification
    if params[:areas]
			params[:areas].each do |area|
				area_de_interesse = AreaDeInteresse.find_by_name(area)
				if area_de_interesse
					AreaNotFoundNotification.create({user_id: current_user.id, area_de_interesse_id: area_de_interesse.id})
				end
			end
    end
		render json: :oi
  end

end
