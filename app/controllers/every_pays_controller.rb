class EveryPaysController < ApplicationController
  before_action :set_every_pay, only: %i[ show edit update destroy payment pay]
  require "active_merchant_every_pay"
  skip_before_action :verify_authenticity_token, only: [:payment,:pay]

  # GET /every_pays or /every_pays.json
  def index
    @every_pays = EveryPay.all
  end

  def payment_success

    gateway = ActiveMerchant::Billing::EveryPayGateway.new(
              api_username: "22a8a6b1324144b0",
              api_secret: "8260872fe1b2b30d1753f3d360cf6e83",
              account_name: "EUR3D1",
              gateway_url: "https://igw-demo.every-pay.com/api/v4",
              # customer_url: "http://localhost:3000/paid"
              customer_url: "http://example.com/paid"
            )
    payment_response = gateway.result(payment_reference: params[:payment_reference])
    EveryPay.create status: payment_response.params['success']? 'success' : 'pending' ,amount: payment_response.params['initial_amount'] , payment_reference: params[:payment_reference]
    abort(payment_response.to_json)
  end

def payment
  
gateway = ActiveMerchant::Billing::EveryPayGateway.new(
  api_username: "22a8a6b1324144b0",
  api_secret: "8260872fe1b2b30d1753f3d360cf6e83",
  account_name: "EUR3D1",
  gateway_url: "https://igw-demo.every-pay.com/api/v4",
  # customer_url: "http://localhost:3000/paid"
  customer_url: "http://example.com/paid"
)
# Authorize for 10 euros and 34 cents
response = gateway.authorize(params[:amount].to_i*100, order_reference: "order ##{rand(1..9)}", email: params[:email_address], customer_ip: "127.0.0.1",
billing_line1: params[:address],
billing_postcode: params[:zip_code],
billing_state: params[:state],
billing_city: params[:city],
billing_country: params[:country]

)

# Use this url to redirect user to merchant portal
response.authorization
# Read status
data = gateway.result(payment_reference: response.payment_reference)
redirect_to data.params['payment_link']
# puts data.to_json
end


  # GET /every_pays/1 or /every_pays/1.json
  def show
  end

  # GET /every_pays/new
  def new
    @every_pay = EveryPay.new
  end

  # GET /every_pays/1/edit
  def edit
  end

  # POST /every_pays or /every_pays.json
  def create
    @every_pay = EveryPay.new(every_pay_params)

    respond_to do |format|
      if @every_pay.save
        format.html { redirect_to @every_pay, notice: "Every pay was successfully created." }
        format.json { render :show, status: :created, location: @every_pay }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @every_pay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /every_pays/1 or /every_pays/1.json
  def update
    respond_to do |format|
      if @every_pay.update(every_pay_params)
        format.html { redirect_to @every_pay, notice: "Every pay was successfully updated." }
        format.json { render :show, status: :ok, location: @every_pay }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @every_pay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /every_pays/1 or /every_pays/1.json
  def destroy
    @every_pay.destroy
    respond_to do |format|
      format.html { redirect_to every_pays_url, notice: "Every pay was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_every_pay
      @every_pay = EveryPay.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def every_pay_params
      params.require(:every_pay).permit(:status, :amount, :response)
    end
end
