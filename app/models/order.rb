class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course
  validates :pay_type, presence: true

  validates :status, presence: true
  validates :token, presence: true

  def send_invoice_request
    response = generate_invoice

    self.token = response[:token]
    self.status = response[:status]
  end

  def situation
    if self.status.eql?'approved'
      save
    end
  end

  private

  def generate_invoice
    Invoice.generate(token_user: user.token,
                     token_course: course.token,
                     token_pay_type: pay_type
                    )
  end
end
