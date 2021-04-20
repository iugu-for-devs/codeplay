class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, :video_code, presence: true
  validates :video_code, uniqueness: true
end
