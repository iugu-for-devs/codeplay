class OrdersController < ApplicationController
  before_action :authenticate_user!
  def new
    @course = Course.find(params[:course])
    @order = Order.new
  end

  def create
    @course = Course.find(params[:course])
    @order = Order.new( course: @course,
                        user: current_user,
                        pay_type: params[:pay_type])

    # response = Invoice.generate(token_user: current_user.token, token_course: @course.token, token_pay_type: params[:pay_type])
    # @order = Order.new(pay_type: params[:pay_type], status: response[:status])
    
    @order.send_invoice_request
    
    return redirect_to @course, notice: t('.success') if @order.save
    
  end
end
