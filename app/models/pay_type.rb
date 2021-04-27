class PayType
  attr_reader :name

  def initialize(name:, token:)
    @name = name
    @token = token
  end

  def self.all
    url = "https://my-json-server.typicode.com/JorgeLAB/codeplay/paytypes"
    response = Faraday.get(url, 'Content-Type' => 'application/json')
    pay_types = JSON.parse(response.body, symbolize_names: true)
    pay_types.map { |pay_type| new(name: pay_type[:name], token: pay_type[:token] ) }
  end

  def load_url(endpoint, company_key); end
end

# TODO: Plataforma de pagamento deve retornar os tipos de pagamento
