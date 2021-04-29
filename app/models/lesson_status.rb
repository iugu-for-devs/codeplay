class LessonStatus < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  enum status: {undone: 10, done: 20}
end