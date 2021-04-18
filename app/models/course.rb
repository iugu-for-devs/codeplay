class Course < ApplicationRecord
  has_many :subscription_courses
  has_many :subscriptions, through: :subscription_courses

end
