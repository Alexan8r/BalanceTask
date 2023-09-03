require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { create(:user) }

  it 'is valid with a name, amount, kind, and user' do
    event = Event.new(name: 'Salary', amount: 1000, kind: 'income', user: user)
    expect(event).to be_valid
  end

  it 'is invalid without a name' do
    event = Event.new(name: nil, amount: 1000, kind: 'income', user: user)
    expect(event).to_not be_valid
    expect(event.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without an amount' do
    event = Event.new(name: 'Salary', amount: nil, kind: 'income', user: user)
    expect(event).to_not be_valid
    expect(event.errors[:amount]).to include("can't be blank")
  end

  it 'is invalid without a kind' do
    event = Event.new(name: 'Salary', amount: 1000, kind: nil, user: user)
    expect(event).to_not be_valid
    expect(event.errors[:kind]).to include("is not included in the list")
  end

  it 'is invalid with an invalid kind' do
    event = Event.new(name: 'Salary', amount: 1000, kind: 'invalid', user: user)
    expect(event).to_not be_valid
    expect(event.errors[:kind]).to include("is not included in the list")
  end

  it 'is invalid with a negative amount' do
    event = Event.new(name: 'Salary', amount: -1000, kind: 'income', user: user)
    expect(event).to_not be_valid
    expect(event.errors[:amount]).to include("must be greater than 0")
  end

  it 'belongs to a user' do
    association = Event.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end
end