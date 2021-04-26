class TextLesson < ApplicationRecord
  belongs_to :course
  validates :name, :lesson_body, presence: true
end
