class Order < ApplicationRecord
  validates :pay_type, presence: true
end
