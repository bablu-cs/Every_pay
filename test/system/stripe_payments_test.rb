require "application_system_test_case"

class StripePaymentsTest < ApplicationSystemTestCase
  setup do
    @stripe_payment = stripe_payments(:one)
  end

  test "visiting the index" do
    visit stripe_payments_url
    assert_selector "h1", text: "Stripe Payments"
  end

  test "creating a Stripe payment" do
    visit stripe_payments_url
    click_on "New Stripe Payment"

    fill_in "Amount", with: @stripe_payment.amount
    fill_in "Customer", with: @stripe_payment.customer_id
    fill_in "Status", with: @stripe_payment.status
    click_on "Create Stripe payment"

    assert_text "Stripe payment was successfully created"
    click_on "Back"
  end

  test "updating a Stripe payment" do
    visit stripe_payments_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @stripe_payment.amount
    fill_in "Customer", with: @stripe_payment.customer_id
    fill_in "Status", with: @stripe_payment.status
    click_on "Update Stripe payment"

    assert_text "Stripe payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Stripe payment" do
    visit stripe_payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stripe payment was successfully destroyed"
  end
end
