class GenerateInvoice
  def initialize(token_course:, token_user:, token_pay_type:)
    @token_course = ''
    @token_user = ''
    @token_pay_type = ''
  end

  def generated_invoice
    possible_status = %w[refused pending approved]
    returned_token = '0123456789'

    { status: possible_status.sample, token: returned_token }
  end
end

# TODO: Devemos persistir pedido de faturas recusados? acho que sim
# TODO: Devemos ter token de pedido de faturas recusada ? acho que sim
