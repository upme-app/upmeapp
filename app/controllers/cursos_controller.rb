class CursosController < ApplicationController

  def all
    render json: CursoSuperior.all.pluck(:nome)
  end

end
