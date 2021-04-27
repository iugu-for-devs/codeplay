require 'rails_helper'

describe User do
  let(:user_configurator) { instance_double(UserConfigurator) }

  context '#configurate_buyer_profile' do
    it 'generate token on creation' do
      user = Fabricate.build(:user)
      allow(UserConfigurator).to receive(:new).and_return(user_configurator)
      allow(user_configurator).to receive(:call) { user.update(payment_token: SecureRandom.hex(10)) }

      user.save
      expect(user.payment_token).to be_present
    end

    it 'if error raised do nothing' do
      user = Fabricate.build(:user)
      allow(UserConfigurator).to receive(:new).and_return(user_configurator)
      allow(user_configurator).to receive(:call).and_raise(Faraday::ConnectionFailed.new('expired'))
      allow(Rails.logger).to receive(:error)

      user.save
      expect(user.payment_token).to be_blank
      expect(Rails.logger).to have_received(:error).with('Não foi possível criar perfil de pagamento')
    end
  end
end
