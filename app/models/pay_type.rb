class PayType
  attr_reader :name

  def initialize(name:, token:)
    @name = name
    @token = token
  end

  def self.all
    [
      new(name: 'Boleto', token: '0123456789' ),
      new(name: 'Cartão de Crédito', token: '3333333333'),
      new(name: 'PIX', token: '4444444444')
    ]
  end
end

# TODO: Plataforma de pagamento deve retornar os tipos de pagamento
