Rails.application.routes.draw do
  get 'orders/index'
  root to: "items#index"
end
