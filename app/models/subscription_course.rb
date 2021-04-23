class SubscriptionCourse < ApplicationRecord
  belongs_to :course
  belongs_to :subscription

  validates :course, uniqueness: { scope: :subscription }
end
