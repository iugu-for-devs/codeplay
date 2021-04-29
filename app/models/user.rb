class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :courses, through: :orders
  has_many :subscriptions, through: :orders

  def own_course?(course)
    user_courses = approved_courses
    user_courses.include? course
  end

  def approved_courses
    orders.where(status: 'approved').map(&:course)
  end

  def own_subscription?(subscription)
    user_subscription = approved_subscription
    user_subscription.include? subscription
  end

  def approved_subscription
    orders.where(status: 'approved').map(&:subscription)
  end
end
