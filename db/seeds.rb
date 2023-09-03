20.times do
  User.create(name: Faker::Name.first_name, surname: Faker::Name.last_name, balance: rand(1000..10000))
end