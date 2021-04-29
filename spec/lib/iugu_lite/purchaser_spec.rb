require 'rails_helper'

describe IuguLite::Purchaser do
  context '.create' do
    it 'send request to iugu-lite to create purchaser' do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .with('purchasers')
        .and_return(
          instance_double(
            Faraday::Response, status: 200,
                               body: JSON.parse(File.read(Rails.root.join('spec/fixtures/purchaser.json')))
          )
        )

      purchaser = described_class.create(email: 'purchaser@test.com')
      expect(purchaser).to be_instance_of(IuguLite::Purchaser)
      expect(purchaser.email).to eq 'purchaser@test.com'
      expect(purchaser.token).to eq '35df8639cb4afd644621e6736830aa7af57e9b97'
      expect(purchaser.name).to  eq 'Purchaser'
    end

    it 'if timeout request raise error' do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .and_raise(Faraday::TimeoutError)

      expect do
        described_class.create(email: 'purchaser@test.com')
      end.to raise_error(Faraday::TimeoutError)
    end

    it 'if fail request raise error' do
      allow_any_instance_of(Faraday::Connection).to receive(:post)
        .and_raise(Faraday::ConnectionFailed.new('expired'))

      expect do
        described_class.create(email: 'purchaser@test.com')
      end.to raise_error(Faraday::ConnectionFailed)
    end
  end
end
