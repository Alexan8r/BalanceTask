require 'rails_helper'

RSpec.describe UserSummaryService do
  let(:user) { create(:user, balance: 100.0) }
  let(:service) { UserSummaryService.new(user, {}) }

  describe '#call' do
    it 'returns the user summary' do
      event1 = create(:income_event, user_id: user.id, amount: 100.0, date: Date.current)
      event2 = create(:consumption_event, user_id: user.id, amount: 100.0, date: Date.current)

      summary = service.call

      expect(summary[:beginning_of_period].to_i).to eq(100)
      expect(summary[:end_of_period].to_i).to eq(100)
      expect(summary[:balance].to_i).to eq(user.balance)
      expect(summary[:events]).to eq([event1, event2])
    end
  end
end