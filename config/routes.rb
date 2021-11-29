Rails.application.routes.draw do
  resources :stripe_payments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  post '/payment/charge', to: 'stripe_payments#pay', as: 'stripe_paymentgateway'
  root to: "stripe_payments#index"
end
