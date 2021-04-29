class Invoice
  def initialize(data:, token:, pay_type:); end

  def self.generate(attributes = {})
    endpoint = 'invoices_generate_refused'
    get_request(endpoint, attributes).first
  end

  def self.conn_faraday
    Faraday.new(
      url: 'https://my-json-server.typicode.com/JorgeLAB/codeplay/',
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  def self.get_request(endpoint, data = {})
    response = conn_faraday.get(endpoint) { |req| req.params = data }
    load_json(response)
  end

  def self.load_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
