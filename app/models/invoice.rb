class Invoice
  
  def initialize(data:, token:, pay_type:)
  end

  def self.generate(token_course:, token_user:, token_pay_type:)
    possible_status = %w[refused pending approved]
    returned_token = '0123456789'

    { status: 'approved', token: returned_token }
  end
end

# TODO: Devemos persistir pedido de faturas recusados? acho que sim
# TODO: Devemos ter token de pedido de faturas recusada ? acho que sim
