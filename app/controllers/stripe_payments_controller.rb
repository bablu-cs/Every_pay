class StripePaymentsController < ApplicationController
  before_action :set_stripe_payment, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:pay]

  require 'stripe'
  require 'json'

  # GET /stripe_payments or /stripe_payments.json
  def index
    @stripe_payments = StripePayment.all
    #for get response data and access them
    #  @stripe_payments = StripePayment.find(2)
    #   data=@stripe_payments.response
    #   data=JSON.parse(data)
    #  abort(data['id'])
  end
def pay
    Stripe.api_key = 'sk_test_51Jyt87SG0QTZvhDzd8HfZOQ5oU4dFlUzo2M6rLdr95eA10KEKiGnfJzs5PyAfs5QmvzTEQ0h3UvLgx7vXfa6eaKN00dBqNR3Bd'
    customer = Stripe::Customer.create(
            :email => 'bablu@gmaiil.com',
            :card  => params[:stripeToken]
            )
   
    response_data= Stripe::Charge.create({
      customer: customer.id,
      amount: params[:amount],#4000,#amount
      currency: 'inr',
      description: 'Payments test from rails test application',
      :metadata => {
        "Wallet_id" => params[:wallet_id]
      },
    "shipping": {
      "address": {
        "city" => "Chandigarh",
        "country" => "IN",
        "line1" => "Deepcomplex Chandigarh",
        "line2" => "Chandigarh",
        "postal_code" => "160002",
        "state" => "CHD"
      },
      "name": 'bablu',
      "phone": "8451515165"
   },
    })
    if response_data.status == 'succeeded'
      # redirect_url='here'
      charge_data = Stripe::Charge.retrieve(response_data.id,)
      StripePayment.create status: response_data.status, response: charge_data ,amount: response_data.amount/100,customer_id: customer.id

      respond_to do |format|
        format.html { redirect_to stripe_payments_url, notice: "Stripe payment was successfully paid." }
      end
    else
      respond_to do |format|
        format.html { redirect_to stripe_payments_url, notice: "Stripe payment was failed." }
      end
    end
    

# abort(response_data.to_json)
end
  # GET /stripe_payments/1 or /stripe_payments/1.json
  def show
  end

  # GET /stripe_payments/new
  def new
    @stripe_payment = StripePayment.new
  end

  # GET /stripe_payments/1/edit
  def edit
  end

  # POST /stripe_payments or /stripe_payments.json
  def create
    @stripe_payment = StripePayment.new(stripe_payment_params)

    respond_to do |format|
      if @stripe_payment.save
        format.html { redirect_to @stripe_payment, notice: "Stripe payment was successfully created." }
        format.json { render :show, status: :created, location: @stripe_payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stripe_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stripe_payments/1 or /stripe_payments/1.json
  def update
    respond_to do |format|
      if @stripe_payment.update(stripe_payment_params)
        format.html { redirect_to @stripe_payment, notice: "Stripe payment was successfully updated." }
        format.json { render :show, status: :ok, location: @stripe_payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stripe_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stripe_payments/1 or /stripe_payments/1.json
  def destroy
    @stripe_payment.destroy
    respond_to do |format|
      format.html { redirect_to stripe_payments_url, notice: "Stripe payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stripe_payment
      @stripe_payment = StripePayment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stripe_payment_params
      params.require(:stripe_payment).permit(:customer_id, :amount, :status)
    end
end
