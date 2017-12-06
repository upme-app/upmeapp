class StripeChargesService
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  DEFAULT_CURRENCY = 'brl'.freeze

  def initialize(params, user)
    @stripe_email = params[:stripeEmail]
    @stripe_token = params[:stripeToken]
    @project = params[:project_id]
    @user = user
  end

  # class methods .............................................................
  # public instance methods ...................................................
  def call
      customer = retrieve_customer(stripe_token)

      customer = Stripe::Customer.create(email: user.email, source: stripe_token) if customer.nil?
      user.update(stripe_token: customer.id)
      create_charge(customer)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................

  attr_accessor :user, :stripe_email, :stripe_token, :project
  private

  #
  # def find_customer
  #   if user.stripe_token
  #     customer = retrieve_customer(user.stripe_token)
  #     if customer.nil?
  #       create_customer
  #     end
  #   end
  # end
  #
  def retrieve_customer(stripe_token)

    begin
      Stripe::Customer.retrieve(stripe_token)

    rescue Stripe::CardError, Stripe::InvalidRequestError => e
      nil
    end
  end
  #
  # def create_customer
  #   begin
  #     customer = Stripe::Customer.create(email: user.email, source: stripe_token)
  #
  #     user.update(stripe_token: customer.id)
  #     customer
  #
  #   rescue Stripe::CardError, Stripe::InvalidRequestError => e
  #     e
  #   end
  #
  # end

  def create_charge(customer)
    payment = create_payment
    Stripe::Charge.create(
        customer: customer.id,
        amount: order_amount,
        description: customer.email,
        currency: DEFAULT_CURRENCY,
        metadata: {payment_id: payment.id}
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
    100
  end
end
