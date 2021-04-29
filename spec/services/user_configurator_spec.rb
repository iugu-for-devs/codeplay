require 'rails_helper'

describe UserConfigurator do
  subject { UserConfigurator.new(user).call }
  context 'creates payment token' do
    let(:user) { Fabricate(:user) }
    it do
      allow(IuguLite::Purchaser).to receive(:create)
        .and_return({ payment_token: SecureRandom.hex(10) })
      subject
      expect(user.payment_token).to be_present
    end
  end

  context 'without persistion' do
    let(:user) { Fabricate.build(:user) }
    it do
      instance = UserConfigurator.new(user)
      allow(UserConfigurator).to receive(:new).with(user).and_return(instance)
      expect(instance).not_to receive(:create_buyer_profile)
      subject
    end
  end

  context 'with payment token' do
    let(:user) { Fabricate.create(:user, payment_token: SecureRandom.hex(10)) }
    it do
      expect(IuguLite::Purchaser).not_to receive(:create)
      subject
    end
  end
end
