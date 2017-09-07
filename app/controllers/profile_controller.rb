class ProfileController < ApplicationController

  def my_profile
    flash[:success] = 'Perfil atualizado!'
    flash[:danger] = 'Deu ruim!'
  end
end
