class TextLesson < ApplicationRecord
  belongs_to :course
  validates :name, :lesson_body, presence: true
  has_rich_text :lesson_body

  has_many :text_lesson_status, dependent: :nullify
end
