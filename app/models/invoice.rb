class Invoice
  def initialize(data:, token:, pay_type:); end

  def self.generate(attributes = {})
    conn_faraday.post('invoices') do |req|
      req.body = attributes.to_json
    end.body
  end

  private

  def self.conn_faraday
    IuguLite.client
  end
end
