Rails.application.routes.draw do
  root "feed#show"

  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  get "sign_in", to: "sessions#new"
end
