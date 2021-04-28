class TextLesson < ApplicationRecord
  belongs_to :course
  validates :name, :lesson_body, presence: true
  has_rich_text :lesson_body
end
