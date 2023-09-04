Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resources :events, only: :create
    resources :users, only: %i[index show] do
      get :summary, on: :member
    end
  end

end
