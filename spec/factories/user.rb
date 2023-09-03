FactoryBot.define do
  factory :user do
  name { Faker::Name.first_name }
  surname { Faker::Name.last_name }
  balance { rand(10000) }
  end
end