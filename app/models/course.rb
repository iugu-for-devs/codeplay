class Course < ApplicationRecord
  validates :name, :description, presence: true
end
