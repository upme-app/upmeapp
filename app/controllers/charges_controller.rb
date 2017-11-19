class ChargesController < ApplicationController
  before_action :set_project, only: [:create]
  before_action :webhook_verification, only: :payment_notification
  before_action :set_payment, only: :payment_notification

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
    respond_to do |format|
      format.json do
        if params[:data][:object][:paid]
          @payment.update_attribute(:status, 0)
          render json: { success: true }, status: 200
        end
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

  def set_payment
    @payment = Payment.find(params[:data][:object][:metadata][:payment_id])
  end

  def catch_exception(exception)
    flash[:error] = exception.message
  end

  def webhook_verification
    return if verify_webhook
    respond_to do |format|
      format.json { return render json: { success: false }, status: 400 }
    end
  end

  def verify_webhook
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header,
                                              Rails.application.secrets.stripe_endpoint_secret)
    rescue JSON::ParserError => e
      return false
    rescue Stripe::SignatureVerificationError => e
      return false
    end

    true
  end
end
