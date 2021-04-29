class Lesson < ApplicationRecord
  belongs_to :course
  has_many :lesson_status

  validates :name, :video_code, presence: true
  validates :video_code, uniqueness: true

end
