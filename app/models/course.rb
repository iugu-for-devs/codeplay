class Course < ApplicationRecord
  has_many :subscription_courses, dependent: :destroy
  has_many :subscriptions, through: :subscription_courses
end
