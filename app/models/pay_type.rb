class PayType
  attr_reader :name

  def initialize(name:)
    @name = name
  end

  def self.all
    [
      new(name: 'Boleto'),
      new(name: 'Cartão de Crédito'),
      new(name: 'PIX')
    ]
  end
end

# TODO: Plataforma de pagamento deve retornar os tipos de pagamento
