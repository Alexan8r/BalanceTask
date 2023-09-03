## You need to run a sidekiq for it to work correctly.
### Ruby version - 3.2.2
### Rails version - 7.0.7.2
### API:
* namespace :api, defaults: { format: 'json' } do
  + resources :events
  + resources :users do
     + get :summary, on: :member
  + end
* end
