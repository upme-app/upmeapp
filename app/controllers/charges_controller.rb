class ChargesController < ApplicationController
  before_action :set_project, only: [:create]

  rescue_from Stripe::CardError, with: :catch_exception

  def new
  end

  def create
    StripeChargesService.new(charges_params, current_user).call
    flash[:success] = 'Requisição de Pagamento enviada, aguarde confirmação'
    redirect_to  payment_path(@project)
  end

  def payment_notification
    binding.pry
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    respond_to do |format|
      format.json do
        begin
          binding.pry
          event = Stripe::Webhook.construct_event(payload, sig_header,
                                                  Rails.application.secrets.endpoint_secret)
          binding.pry
        rescue JSON::ParserError => e
          render status: 400
          return
        rescue Stripe::SignatureVerificationError => e
          render status: 400
          return
        end

        render json: { success: true }, status: 200
      end
    end
  end

  private

  def charges_params
    params.permit(:stripeEmail, :stripeToken, :project_id, :authenticity_token, :stripeTokenType)
  end

  def set_project
    @project = Project.find(charges_params[:project_id].to_i)
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end
end
