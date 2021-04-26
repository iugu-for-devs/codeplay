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

  def payment_methods
    @payment_methods = PaymentMethods.search(@user.id)
  end

  def create_payment_methods
    @user_info = PaymentMethods.create_token(name: params[:name],
                                             card_number: params[:number],
                                             expiration_date: params[:expiration_date],
                                             security_code: params[:security_code],
                                             user: current_user)
    redirect_to user_payment_methods_path
  end

  def delete_payment_methods
    PaymentMethods.delete_method(params[:card])
    redirect_to user_payment_methods_path
  end

  private

  def set_user
    @user = current_user
  end
end
