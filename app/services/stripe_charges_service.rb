class StripeChargesService
  DEFAULT_CURRENCY = 'brl'.freeze

  def initialize(params, user)
    @stripe_email = params[:stripeEmail]
    @stripe_token = params[:stripeToken]
    @project = params[:project_id]
    @user = user
  end

  def call
    create_charge(find_customer)
  end

  private

  attr_accessor :user, :stripe_email, :stripe_token, :project

  def find_customer
    if user.stripe_token
      retrieve_customer(user.stripe_token)
    else
      create_customer
    end
  end

  def retrieve_customer(stripe_token)
    Stripe::Customer.retrieve(stripe_token)
  end

  def create_customer
    customer = Stripe::Customer.create(
        email: stripe_email,
        source: stripe_token
    )
    user.update(stripe_token: customer.id)
    customer
  end

  def create_charge(customer)
    create_payment
    Stripe::Charge.create(
        customer: customer.id,
        amount: order_amount,
        description: customer.email,
        currency: DEFAULT_CURRENCY
    )
  end

  def create_payment
    Payment.create(
        user_id: @user.id,
        project_id: project,
        order_amount: order_amount,
        currency: DEFAULT_CURRENCY,
        status: :aguardando
    )
  end

  def order_amount
    50000
  end
end