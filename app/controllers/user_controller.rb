class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show; end

  def courses
    @courses = [
      Course.new(
        name: 'Curso de Ruby 1.0',
        description: 'Curso Avançado de Ruby',
        admin_id: 1
      )
    ]
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
    @orders = [
      Order.new(pay_type: 'PIX')
    ]
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end
end
