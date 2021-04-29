require 'rails_helper'

describe 'order', type: :request do
  context 'when params is correct' do
    it 'authentided user can create a order' do
      user = login_user
      course = Fabricate(:course)

      returned_token = Faker::Alphanumeric.alphanumeric(number: 10)
      allow(Invoice).to receive(:get_request).and_return([{ status: 'pedding', token: returned_token }])

      expect do
        post course_orders_path(course), params: { order: Fabricate.attributes_for(:order, user: user) }
      end.to change(Order, :count).by(1)
    end

    it 'user can create a order' do
      user = login_user
      course = Fabricate(:course)
      allow_any_instance_of(Faraday::Connection).to receive(:get).and_raise(Faraday::TimeoutError)

      expect do
        post course_orders_path(course), params: { order: Fabricate.attributes_for(:order, user: user) }
      end.to raise_error(Faraday::TimeoutError)
    end
  end
end
