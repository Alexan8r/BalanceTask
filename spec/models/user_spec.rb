require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name and surname' do
    user = User.new(name: 'John', surname: 'Doe')
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil, surname: 'Doe')
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without a surname' do
    user = User.new(name: 'John', surname: nil)
    expect(user).to_not be_valid
    expect(user.errors[:surname]).to include("can't be blank")
  end
end