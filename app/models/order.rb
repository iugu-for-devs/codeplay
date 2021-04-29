class Order < ApplicationRecord
  belongs_to :user
  belongs_to :course, optional: true
  belongs_to :subscription, optional: true

  validates :pay_type, presence: true

  validates :status, presence: true
  validates :token, presence: true

  def send_invoice_request
    if course
      response = generate_course_invoice 
    else
      response = generate_subscription_invoice
    end
    
    update(token: response[:token], status: response[:status])
  end

  def approved?
    status.eql? 'approved'
  end

  private

  def generate_subscription_invoice
    Invoice.generate(token_user: user.token,
                     token_subscription: subscription.token,
                     token_pay_type: pay_type)
  end

  def generate_course_invoice
    Invoice.generate(token_user: user.token,
                     token_course: course.token,
                     token_pay_type: pay_type)
  end
end
