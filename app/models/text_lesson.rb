class TextLesson < ApplicationRecord
	belongs_to :courses
	validates :name, :lesson_body, presence: true
end
