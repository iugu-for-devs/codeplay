class Subscription < ApplicationRecord
  validates :name, :description, :price, presence: true
  validates :name, uniqueness: true
  has_many :subscription_courses, dependent: :destroy
  has_many :courses, through: :subscription_courses
  has_many :order
end
