class Course < ApplicationRecord
  has_many :lessons, dependent: :nullify
  has_one_attached :cover
  belongs_to :admin
  has_many :subscription_courses, dependent: :destroy
  has_many :subscriptions, through: :subscription_courses
  has_many :orders 
  has_many :users, through: :orders
  validates :name, :description, presence: true

  def self.search(query)
    where('courses.name LIKE ?', "%#{query}%")
  end
end
