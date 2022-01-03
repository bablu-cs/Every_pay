Rails.application.routes.draw do
  resources :stripe_payments
  post '/payment/charge', to: 'stripe_payments#pay', as: 'stripe_paymentgateway' #stripe payment routes
  
  root to: "stripe_payments#index"
end
