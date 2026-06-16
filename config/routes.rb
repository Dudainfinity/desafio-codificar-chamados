Rails.application.routes.draw do
  root "tickets#index"

  resources :tickets do
    member do
      patch :assign_auto
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
