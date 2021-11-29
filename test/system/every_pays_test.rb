require "application_system_test_case"

class EveryPaysTest < ApplicationSystemTestCase
  setup do
    @every_pay = every_pays(:one)
  end

  test "visiting the index" do
    visit every_pays_url
    assert_selector "h1", text: "Every Pays"
  end

  test "creating a Every pay" do
    visit every_pays_url
    click_on "New Every Pay"

    fill_in "Amount", with: @every_pay.amount
    fill_in "Response", with: @every_pay.response
    fill_in "Status", with: @every_pay.status
    click_on "Create Every pay"

    assert_text "Every pay was successfully created"
    click_on "Back"
  end

  test "updating a Every pay" do
    visit every_pays_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @every_pay.amount
    fill_in "Response", with: @every_pay.response
    fill_in "Status", with: @every_pay.status
    click_on "Update Every pay"

    assert_text "Every pay was successfully updated"
    click_on "Back"
  end

  test "destroying a Every pay" do
    visit every_pays_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Every pay was successfully destroyed"
  end
end
