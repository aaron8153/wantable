Rails.application.routes.draw do
  root 'admin#index'

  resources :orders, only: [:index, :show], param: :number

  resources :reports, only: :index do
  end

  post '/reports/coupon_select' => 'reports#coupon_select', as: "coupon_select"
  post '/reports/product_sales' => 'reports#product_sales', as: "product_sales"
end
