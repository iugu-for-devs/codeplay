class Course < ApplicationRecord
  has_many :lessons, dependent: :nullify
  has_one_attached :cover
  belongs_to :admin
  has_many :subscription_courses, dependent: :destroy
  has_many :subscriptions, through: :subscription_courses
  validates :name, :description, presence: true

  has_many :requirements, class_name: "Course",
                          foreign_key: "requirement_id"

  belongs_to :requirement, class_name: "Course", optional: true

  def self.search(query)
    where('courses.name LIKE ?', "%#{query}%")
  end
end
