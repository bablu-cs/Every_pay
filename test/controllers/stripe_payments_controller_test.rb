require "test_helper"

class StripePaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stripe_payment = stripe_payments(:one)
  end

  test "should get index" do
    get stripe_payments_url
    assert_response :success
  end

  test "should get new" do
    get new_stripe_payment_url
    assert_response :success
  end

  test "should create stripe_payment" do
    assert_difference('StripePayment.count') do
      post stripe_payments_url, params: { stripe_payment: { amount: @stripe_payment.amount, customer_id: @stripe_payment.customer_id, status: @stripe_payment.status } }
    end

    assert_redirected_to stripe_payment_url(StripePayment.last)
  end

  test "should show stripe_payment" do
    get stripe_payment_url(@stripe_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_stripe_payment_url(@stripe_payment)
    assert_response :success
  end

  test "should update stripe_payment" do
    patch stripe_payment_url(@stripe_payment), params: { stripe_payment: { amount: @stripe_payment.amount, customer_id: @stripe_payment.customer_id, status: @stripe_payment.status } }
    assert_redirected_to stripe_payment_url(@stripe_payment)
  end

  test "should destroy stripe_payment" do
    assert_difference('StripePayment.count', -1) do
      delete stripe_payment_url(@stripe_payment)
    end

    assert_redirected_to stripe_payments_url
  end
end
