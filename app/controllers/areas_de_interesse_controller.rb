class AreasDeInteresseController < ApplicationController

  before_action :authenticate_user!

  def all_names
    render json: AreaDeInteresse.all.order(name: :asc).pluck(:name).to_json
  end

  def search_all
    render json: AreaDeInteresse.where("name ILIKE ?", "%#{params[:term]}%").order(name: :asc).pluck(:name)
  end

  def minhas_areas
    arr_areas = []
    current_user.user_area_de_interesse.each do |area|
      arr_areas << area.area_de_interesse.name
    end
    render json: arr_areas
  end

  def view

  end

  def save
    current_user.update_areas_de_interesse(params['areas'])
    flash[:success] = 'Áreas de interesse salvas!'
    if request.referer == explore_url
      redirect_to explore_path
    else
      redirect_to my_profile_path
    end
  end

end
