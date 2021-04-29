class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show; end

  def courses
    @user.courses
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
    @orders = current_user.orders.all
  end

  private

  def set_user
    @user = current_user
  end
end
