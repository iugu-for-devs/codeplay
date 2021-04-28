class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, :video_code, presence: true
  validates :video_code, uniqueness: true
  validates :done, presence: true

  enum done: { uncheck: 10, check: 20 }

  def done?
    return true if done.eql? 'check'
    false
  end
end
