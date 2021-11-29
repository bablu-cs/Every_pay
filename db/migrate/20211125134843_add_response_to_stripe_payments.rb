class AddResponseToStripePayments < ActiveRecord::Migration[6.1]
  def change
    add_column :stripe_payments, :response, :text
  end
end
