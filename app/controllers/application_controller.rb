class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_filter :notifications


  def after_sign_in_path_for(resource_or_scope)
    if current_user.profile_is_complete?
      projects_path
    else
      flash[:success] = 'Complete seu perfil!'
      my_profile_path
    end
  end

  private

  def authorize_admin
    unless current_user.admin
      flash[:danger] = 'Permissão negada.'
      redirect_to root_path
    end
  end

  def notifications
    if current_user
      if params[:read_notification]
        notification = Notification.find(params[:read_notification])
        notification.update_attribute(:read, true) if notification.user_id == current_user.id
      end
      @notifications = current_user.notifications
    end
  end

  def sou_professor?
    current_user and current_user.professor? ? true : false
  end

  def sou_empresa?
    current_user and current_user.empresa? ? true : false
  end

  def sou_aluno?
    current_user and current_user.aluno? ? true : false
  end

end
