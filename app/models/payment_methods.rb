class PaymentMethods
  attr_reader :token, :user_name, :last_digits, :expiration_date, :id

  @@methods =[]

  def initialize(token:, user_name:, last_digits:, expiration_date:, id: )
    @id = id
    @token = token
    @user_name = user_name
    @last_digits = last_digits
    @expiration_date = expiration_date
    @@methods << self
  end
  def self.create_token(card_number:, security_code:, name:, expiration_date:, user: )
    card = {name: name, number: card_number, expiration_date: expiration_date, security_code: security_code, user: user}

    url = 'https://my-json-server.typicode.com/GuiRokk/json_test/users'
    response = Faraday.post(url, card.to_json,
      "Content-Type" => "application/json"
    )

    if response.status == 201
      new(token: SecureRandom.hex(20),
          id: user.id,
          user_name: name,
          last_digits: card_number[12..15],
          expiration_date: expiration_date)
    else
      'Deu erro'
    end
  end

  def self.all
    @@methods

  # [
  #   [1, '1548', '10/05/2021'],
  #   [2,'1548', '10/05/2021'],
  #   [3,'1548', '10/05/2021']
  # ]
  end


  def self.search(id)
    PaymentMethods.all.filter do |credit_card|
      credit_card.id == id
    end
  end


end