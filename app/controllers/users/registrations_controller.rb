class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    set_invite_token
    if @invite and User.find_by_email(@invite.to_email)
      flash[:success] = 'Email já cadastrado. Faça login.'
      redirect_to entrar_path
    else
      super
    end
  end

  # POST /resource
  def create
    # adiciona o email via backend por seguranca
    set_invite_token
    if @invite
      params['user']['email'] = @invite.to_email
    end

    super
    # se conseguir salvar dispara um email de bem vindo
    if current_user
      Thread.new { UserMailer.welcome(current_user).deliver if current_user }
      # se for um save via convite, cria o convite
      if @invite
        ProjectInvitation.create({
                                  user_from_id: @invite.user.id,
                                  user_to_id: current_user.id,
                                  project_id: @invite.project.id
                              })
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_type])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    areas_de_interesse_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def set_invite_token
    if params[:invite_token]
      @invite = InviteEmail.find_by_token(params[:invite_token])
    end
  end
end
