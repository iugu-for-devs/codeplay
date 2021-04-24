class PaymentMethods

  def initialize(token:, user:)
    @token = token
    @user = user
  end

  def self.get_token(card_number:, security_code:, name:, expiration_date:, user: )
    card = {name: name, number: card_number, expiration_date: expiration_date, security_code: security_code, user: user}

    url = 'https://my-json-server.typicode.com/GuiRokk/json_test/users'
    response = Faraday.post(url, card.to_json,
      "Content-Type" => "application/json"
    )

    if response.status == 201
      new(token: SecureRandom.hex(20), user: user)
    else
      'Deu erro'
    end
  end
end