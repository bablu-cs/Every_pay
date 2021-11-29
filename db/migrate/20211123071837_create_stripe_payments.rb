class CreateStripePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_payments do |t|
      t.numeric :customer_id
      t.string :amount
      t.string :status

      t.timestamps
    end
  end
end
