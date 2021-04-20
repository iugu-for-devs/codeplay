class Course < ApplicationRecord
  has_many :lessons, dependent: :nullify
  belongs_to :admin
  has_one_attached :cover

  validates :name, :description, presence: true
end
