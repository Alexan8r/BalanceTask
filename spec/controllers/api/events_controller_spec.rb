require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  describe 'POST #create' do
    context 'with valid event params' do
      let(:user) {create(:user)}
      let(:event_params) { { name: 'Salary', amount: 1000, kind: 'income', user_id: user.id } }

      it 'creates a new event and returns the result' do
        expect {
          post :create, params: { event: event_params }
        }.to change(Event, :count).by(1)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with blank event params' do
      it 'returns an error message' do
        post :create, params: { event: {} }

        expect(response.body).to eq('blank_params')
      end
    end
  end
end