class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show; end

  def courses
    @courses = Course.where(course_id: User.orders.course_id)
  end

  def subscriptions
    @subscriptions = [
      Subscription.new(
        name: 'Jornada Web com Rails',
        description: 'Esta assinatura ira abranger todos os cursos de Ruby e Rails',
        price: 50
      )
    ]
  end

  def orders
    @orders = Order.where(user_id: current_user.id)
  end

  private

  def set_user
    @user = current_user
  end
end
