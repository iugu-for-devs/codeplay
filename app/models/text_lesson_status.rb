class TextLessonStatus < ApplicationRecord
  belongs_to :user
  belongs_to :text_lesson

  enum status: { undone: 10, done: 20 }
end
