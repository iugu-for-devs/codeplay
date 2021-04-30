class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show; end

  def courses
    @courses = current_user.courses
  end

  def subscriptions
    @subscriptions = current_user.subscriptions
  end

  def orders
    @orders = current_user.orders
  end

  private

  def set_user
    @user = current_user
  end
end
