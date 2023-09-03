Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resources :events
    resources :users do
      get :summary, on: :member
    end
  end

end
