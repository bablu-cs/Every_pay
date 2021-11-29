json.extract! stripe_payment, :id, :customer_id, :amount, :status, :created_at, :updated_at
json.url stripe_payment_url(stripe_payment, format: :json)
