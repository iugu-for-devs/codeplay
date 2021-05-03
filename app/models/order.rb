class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course, optional: true
  belongs_to :subscription, optional: true

  validates :pay_type, presence: true

  validates :status, presence: true
  validates :token, presence: true

  def send_invoice_request
    response = if course
                 generate_course_invoice
               else
                 generate_subscription_invoice
               end

    update(token: response[:token], status: response[:status])
  end

  def approved?
    status.eql? 'approved'
  end

  def pay_type_obj
    response = IuguLite.client.get("company_payment_methods/#{pay_type}")
    PayType.new(**response.body)
  end

  private

  def generate_subscription_invoice
    Invoice.generate(token_user: user.token,
                     token_subscription: subscription.token,
                     token_pay_type: pay_type)
  end

  def generate_course_invoice
    Invoice.generate(
      amount: course.price,
      due_date: 1.day.from_now,
      purchaser: user.payment_token,
      product: course.token,
      company_payment_method: pay_type
    )
  end
end
