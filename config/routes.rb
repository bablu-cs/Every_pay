Rails.application.routes.draw do
  resources :every_pays
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/paid' ,to: "resources#payment_success"
  post '/every_pay/payment' , to: "every_pays#payment"
end
