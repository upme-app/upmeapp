class AreasDeInteresseController < ApplicationController

  def all_names
    render json: AreaDeInteresse.all.pluck(:name).to_json
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
    redirect_to my_profile_path
  end

end
