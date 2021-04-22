class OrdersController < ApplicationController
  before_action :authenticate_user!
  def new
    @course = Course.find(params[:course])
    @order = Order.new
  end

  def create
    @course = Course.find(params[:course])
    @order = Order.new(pay_type: params[:pay_type])

    
    return redirect_to @course, notice: t('.success') if @order.save

    flash.now[:notice] = @order.errors.full_messages
    render :new
  end
end
