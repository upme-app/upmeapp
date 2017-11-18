class ChargesController < ApplicationController
  before_action :set_project, only: [:create]

  rescue_from Stripe::CardError, with: :catch_exception
  def new
  end

  def create
    StripeChargesService.new(charges_params, current_user).call
    flash[:success] = 'Pagamento Enviado'
    redirect_to  payment_path(@project)
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken, :project_id,:authenticity_token, :stripeTokenType)
  end

  def set_project
    @project = Project.find(charges_params[:project_id].to_i)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end