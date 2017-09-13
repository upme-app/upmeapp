class CursosController < ApplicationController

  before_action :authenticate_user!

  def all
    render json: CursoSuperior.all.pluck(:nome)
  end

end
