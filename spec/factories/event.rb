FactoryBot.define do
  factory :income_event, class: 'Event' do
    name {"income #{rand(1000..10000)}" }
    amount {rand(100..10000)}
    kind { 'income' }
    user { create(:user) }
  end

  factory :consumption_event, class: 'Event' do
    name {"consumption #{rand(1000..10000)}" }
    amount {rand(100..1000)}
    kind { 'consumption' }
    user { create(:user) }
  end
end