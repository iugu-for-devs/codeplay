class Course < ApplicationRecord
  has_many :lessons, dependent: :nullify
  has_many :text_lessons, dependent: :nullify
  has_one_attached :cover
  belongs_to :admin
  has_many :subscription_courses, dependent: :destroy
  has_many :subscriptions, through: :subscription_courses
  has_many :orders, dependent: :destroy
  has_many :users, through: :orders

  has_many :requirements, class_name: 'Course',
                          foreign_key: 'requirement_id', dependent: :nullify, inverse_of: :requirement

  belongs_to :requirement, class_name: 'Course', optional: true, inverse_of: :requirements

  validates :name, :description, presence: true

  has_many :lesson_statuses, through: :lessons

  def self.search(query)
    where('courses.name LIKE ?', "%#{query}%")
  end

  def lesson_statuses_by_user(user)
    lesson_statuses.where(user: user)
  end
end
