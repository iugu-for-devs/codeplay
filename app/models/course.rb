class Course < ApplicationRecord
  belongs_to :admin
  has_one_attached :cover

  validates :name, :description, presence: true
end
