require "test_helper"

class EveryPaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @every_pay = every_pays(:one)
  end

  test "should get index" do
    get every_pays_url
    assert_response :success
  end

  test "should get new" do
    get new_every_pay_url
    assert_response :success
  end

  test "should create every_pay" do
    assert_difference('EveryPay.count') do
      post every_pays_url, params: { every_pay: { amount: @every_pay.amount, response: @every_pay.response, status: @every_pay.status } }
    end

    assert_redirected_to every_pay_url(EveryPay.last)
  end

  test "should show every_pay" do
    get every_pay_url(@every_pay)
    assert_response :success
  end

  test "should get edit" do
    get edit_every_pay_url(@every_pay)
    assert_response :success
  end

  test "should update every_pay" do
    patch every_pay_url(@every_pay), params: { every_pay: { amount: @every_pay.amount, response: @every_pay.response, status: @every_pay.status } }
    assert_redirected_to every_pay_url(@every_pay)
  end

  test "should destroy every_pay" do
    assert_difference('EveryPay.count', -1) do
      delete every_pay_url(@every_pay)
    end

    assert_redirected_to every_pays_url
  end
end
