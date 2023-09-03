require 'rails_helper'

RSpec.describe EventCreationService do
  describe '#perform' do
    let(:user) { create(:user, balance: 100) }
    let(:params) { { 'user_id' => user.id, 'kind' => 'income', 'name' => 'Salary', 'amount' => 100 } }

    context 'with concurrent income transactions' do
      it 'creates income transactions and updates the user balance correctly' do
        threads = []
        expected_transactions = 100
        expected_balance = user.balance + (params['amount'] * expected_transactions)

        expected_transactions.times do
          threads << Thread.new do
            EventCreationService.new(params).call
          end
        end

        threads.each(&:join)

        expect(Event.count).to eq(expected_transactions)
        expect(user.reload.balance).to eq(expected_balance)
      end
    end

    context 'with concurrent consumption transactions' do
      before { user.update(balance: 100000) }

      it 'creates consumption transactions and updates the user balance correctly' do
        threads = []
        expected_transactions = 100
        expected_balance = user.balance - (params['amount'] * expected_transactions)

        expected_transactions.times do
          threads << Thread.new do
            EventCreationService.new(params.merge('kind' => 'consumption')).call
          end
        end

        threads.each(&:join)

        expect(Event.count).to eq(expected_transactions)
        expect(user.reload.balance).to eq(expected_balance)
      end
    end

  end
end
