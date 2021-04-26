require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should validate_presence_of(:pay_type) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:token) }

  it { should belong_to :course }
  it { should belong_to :user }

  # método de intancia já que iremos esperar valores que modifiquem o status do produto

  context 'when create a order' do
    context '.send_invoice_request' do
      it 'can change order status' do
        client = Fabricate(:user)
        course = Fabricate(:course)
        payment_method_chosen = PayType.all.first

        order = Order.new(user: client, course: course, pay_type: payment_method_chosen)
        old_order_status = 'pending'
        returned_token = Faker::Alphanumeric.alphanumeric(number: 10)

        response = order.send_invoice_request

        # (order).to allow receive(:send_invoice_request).and_return({ status: 'approved',
        #                                                             token: returned_token })

        expect(order.status).to_not eq(old_order_status)
      end

      it 'must set order token' do
        client = Fabricate(:user)
        course = Fabricate(:course)
        payment_method_chosen = PayType.all.first
        order = Order.new(user: client, course: course, pay_type: payment_method_chosen)
        returned_token = Faker::Alphanumeric.alphanumeric(number: 10)

        allow(order).to receive(:send_invoice_request).and_return({ status: 'approved',
                                                                    token: returned_token })

        expect(order.token).to eq(returned_token)
      end

      it 'can changing the status to approved' do
        client = Fabricate(:user)
        course = Fabricate(:course)
        payment_method_chosen = PayType.all.first
        order = Order.new(user: client, course: course, pay_type: payment_method_chosen)
        returned_token = Faker::Alphanumeric.alphanumeric(number: 10)

        allow(order).to receive(:send_invoice_request).and_return({ status: 'approved',
                                                                    token: returned_token })

        expect(order.status).to eq('approved')
      end

      it 'can changing the status to refused' do
        client = Fabricate(:user)
        course = Fabricate(:course)
        payment_method_chosen = PayType.all.first
        order = Order.new(user: client, course: course, pay_type: payment_method_chosen)
        returned_token = Faker::Alphanumeric.alphanumeric(number: 10)

        allow(order).to receive(:send_invoice_request).and_return({ status: 'refused',
                                                                    token: returned_token })

        expect(order.status).to eq('refused')
      end
    end
  end
end
