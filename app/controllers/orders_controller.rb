class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_params

  def new
    @course = Course.find(params[:course])
    @order = Order.new
  end

  def create
    @course = Course.find(params[:order][:course_id])
    @order = Order.new(course: @course,
                       user: current_user,
                       pay_type: params[:pay_type])

    @order.save
    @order.send_invoice_request

    if @order.approved?
      return redirect_to @course, notice: t('.success')
    end
  end

  private

  def set_order_params
    params.require(:order).permit(:user, :course_id, :pay_type_id)
  end
end
