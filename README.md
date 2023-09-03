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

### Required data for user:
* name: string
* surname: string
* balance: decimal, greater_than: 0

### Required data for event:
* amount: decimal, greater_than: 0
* kind: string, inclusion: %w[income consumption]
* name: string
* user_id: reference
