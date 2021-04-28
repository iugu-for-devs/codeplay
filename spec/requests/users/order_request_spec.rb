require 'rails_helper'

describe 'order', type: :request do

  context 'when params is correct' do
    it 'user can create a order' do
      user = login_user
      course = Fabricate(:course)

      post '/orders', params: { order: Fabricate.attributes_for(:order, user: user, course: course) }
      follow_redirect!

      expect(response).to have_http_status(:ok)
    end
  end
end
