require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it 'attributes cannot be in blank' do
    subscription = Subscription.new

    refute subscription.valid?
    expect(subscription.errors[:name]).to include('não pode ficar em branco')
    expect(subscription.errors[:description]).to include('não pode ficar em branco')
    expect(subscription.errors[:price]).to include('não pode ficar em branco')
  end

  it 'name should be uniq' do
    other_subscription = Fabricate(:subscription)
    subscription = Subscription.new(name: other_subscription.name)

    refute subscription.valid?
    expect(subscription.errors[:name]).to include('já está em uso')
  end
end
