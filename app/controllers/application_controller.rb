class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    if current_user.profile_is_complete?
      projects_path
    else
      flash[:success] = 'Complete seu perfil!'
      my_profile_path
    end
  end

end
