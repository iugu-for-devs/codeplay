class PayType
  attr_reader :name, :token

  def initialize(name:, token:)
    @name = name
    @token = token
  end

  def self.all
    endpoint = 'paytypes'
    pay_types = get_request(endpoint)

    pay_types.map { |pay_type| create_paytype(pay_type) }
  end

  class << self
    def conn_faraday
      Faraday.new(
        url: 'https://my-json-server.typicode.com/JorgeLAB/codeplay/',
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def get_request(endpoint, data = {})
      response = conn_faraday.get(endpoint) { |req| req.params = data }
      load_json(response: response)
    end

    def load_json(response:)
      JSON.parse(response.body, symbolize_names: true)
    end

    def create_paytype(attributes = {})
      new(**attributes)
    end
  end

  def self.name(pay_type)
    name = PayType.all.select{ |type|  type.token == pay_type}
    name.first.name
  end


end

# TODO: Podemos abstrair a chamada do faraday
