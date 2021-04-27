class Invoice
  def initialize(data:, token:, pay_type:); end

  def self.generate(token_course:, token_user:, token_pay_type:)
    invoice_data = { token_course: token_course, token_user: token_user, token_pay_type: token_pay_type}

    endpoint = "invoices_generate_approved"

    url = "https://my-json-server.typicode.com/JorgeLAB/codeplay/#{endpoint}"

    Faraday.post(url, invoice_data.to_json, 'Content-Type' => 'application/json')
  end
end

# TODO: Devemos persistir pedido de faturas recusados? acho que sim
# TODO: Devemos ter token de pedido de faturas recusada ? acho que sim
