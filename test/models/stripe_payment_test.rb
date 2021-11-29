# == Schema Information
#
# Table name: stripe_payments
#
#  id          :integer          not null, primary key
#  customer_id :decimal(, )
#  amount      :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  response    :text
#
require "test_helper"

class StripePaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
