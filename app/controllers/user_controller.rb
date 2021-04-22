class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_visitor
  before_action :redirect_unwanted

  def show; end

  def courses
    @course = Course.new(
      name: 'Curso de Ruby 1.0',
      description: 'Curso Avançado de Ruby',
      admin_id: 1
    )
  end

  def subscriptions
    @subscription = Subscription.new(
      name: 'Jornada Web com Rails',
      description: 'Esta assinatura ira abranger todos os cursos de Ruby e Rails',
      price: 50
    )
  end

  def orders
    @order = Order.new(pay_type: 'PIX')
  end

  private

  def set_visitor
    @user = User.find(params[:id])
  end

  def redirect_unwanted
    return if @user.permited?(current_user)

    redirect_to root_path
  end
end
