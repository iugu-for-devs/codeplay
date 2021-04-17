class Course < ApplicationRecord
  belongs_to :admin

  validates :name, :description, presence: true
end
