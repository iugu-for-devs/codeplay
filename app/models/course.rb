class Course < ApplicationRecord
  has_many :lessons, dependent: :nullify
end
