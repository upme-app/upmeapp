class AreasDeInteresseController < ApplicationController

  before_action :authenticate_user!

  def all_names
    render json: AreaDeInteresse.all.order(name: :asc).pluck(:name).to_json
  end

  def search_all
    render json: AreaDeInteresse.where("name ILIKE ?", "%#{params[:term]}%").order(name: :asc).pluck(:name)
  end

end
