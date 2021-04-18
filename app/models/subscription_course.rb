class SubscriptionCourse < ApplicationRecord
  belongs_to :course
  belongs_to :subscription
end
