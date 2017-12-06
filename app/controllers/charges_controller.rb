class ChargesController < ApplicationController
  before_action :set_project, only: [:create]
  before_action :webhook_verification, only: :payment_notification
  before_action :set_payment, only: :payment_notification

  #rescue_from Stripe::CardError, with: :catch_exception

  def new
  end

  def create
    begin
      StripeChargesService.new(charges_params, current_user).call
      # No exceptions were raised; Set our success message.
      flash[:danger] = 'Card charged successfully.'
    rescue Stripe::RateLimitError => e
      flash[:danger] = 'Nossa API recebeu muitas conexões neste momento, tente novamente.'
      # Too many requests made to the API too quickly
    rescue Stripe::InvalidRequestError => e
      flash[:danger] = 'Parametros incorretos'
      # Invalid parameters were supplied to Stripe's API
    rescue Stripe::AuthenticationError => e
      flash[:danger] = 'Falha na autenticação com api'
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
    rescue Stripe::APIConnectionError => e
      flash[:danger] = 'Falha na Conexão com API'
      # Network communication with Stripe failed
    rescue Stripe::StripeError => e
     if  e.http_status == 402
      flash[:danger] = 'Seu cartao foi recusado'
      end
      # Display a very generic error to the user, and maybe send
      # yourself an email
    rescue => e

      flash[:danger] = 'Ocorreu um erro desconhecido'
    end

    redirect_to payment_path(@project)
  end

  def payment_notification
    if params['data']['object']['paid']
      @payment.update_attribute(:status, 0)
      @payment.project.start
      render json: { success: true }, status: 200
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
      format.json {return render json: {success: false}, status: 400}
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
