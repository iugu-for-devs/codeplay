class PayType
  attr_reader :name, :token, :icon

  def initialize(name:, token:, icon:)
    @name = name
    @token = token
    @icon = icon
  end

  def self.all
    endpoint = 'company_payment_methods'
    pay_types = get_request(endpoint)

    pay_types.map { |pay_type| create_paytype(pay_type) }
  end

  class << self
    def conn_faraday
      IuguLite.client
    end

    def get_request(endpoint, data = {})
      response = conn_faraday.get(endpoint)
      response.body
    end

    def load_json(response:)
      JSON.parse(response.body, symbolize_names: true)
    end

    def create_paytype(attributes = {})
      new(**attributes)
    end
  end
end

# TODO: Podemos abstrair a chamada do faraday
