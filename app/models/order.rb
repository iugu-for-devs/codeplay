class Order < ApplicationRecord
  validates :pay_type, presence: true

  def send_invoice_request 
  	GenerateInvoice.new(course_token: course.token, 
  		                  user_token: user.token, 
  		                  pay_type_token: pay_type )
  								 .generate_invoice
  end
end
