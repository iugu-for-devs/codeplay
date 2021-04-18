class Lesson < ApplicationRecord
  belongs_to :course

  validates :name, :video_code, presence: { message: 'não pode ficar em branco' }
  validates :video_code, uniqueness: { message: 'deve ser único' }

  def can_update?(params)
    params.key?(:name) &&
      params.key?(:video_code)
  end
end
