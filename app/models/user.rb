class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  store_accessor :address, :street, :number, :zipcode, :complement, :state, :city
  validates :full_name, :address, :birthdate, :cpf, presence: true

  after_create_commit :configurate_buyer_profile

  has_many :orders, dependent: :destroy
  has_many :courses, through: :orders
  has_many :subscriptions, through: :orders

  def own_course?(course)
    user_courses = approved_courses
    user_courses.include? course
  end

  def approved_courses
    orders.where(status: 'approved').map(&:course).compact
    # orders.where(status: 'approved').map(&:subscription)
  end

  def own_subscription?(subscription)
    user_subscription = approved_subscription
    user_subscription.include? subscription
  end

  def own_course_subscription?(course)
    course_subscription = approved_subscription
    course_subscription.map(&:courses).flatten.include?(course)
  end

  def approved_subscription
    orders.where(status: 'approved').map(&:subscription).compact
  end

  private

  def configurate_buyer_profile
    UserConfigurator.new(self).call
  rescue StandardError
    Rails.logger.error I18n.t('user.purchaser_error')
  end
end
