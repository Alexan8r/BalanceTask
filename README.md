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

### Params for Users/:id/Summary
* date_from: '2023-01-01'
* date_to: '2023-01-02'
* Without_params:
  + date_from: Date.current - 1.day
  + date_to: Date.current
