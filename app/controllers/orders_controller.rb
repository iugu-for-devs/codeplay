class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_params, only: [:create]

  def new
    @course = Course.find(params[:course_id])
    @order = Order.new
  end

  def create
    @course = Course.find(params[:course_id])

    @order = Order.new(course: @course,
                       user: current_user,
                       pay_type: load_params[:pay_type])

    @order.send_invoice_request
    @order.save

    return redirect_to @course, notice: t('.success') if @order.approved?

    if @order.status == 'pending'
      return redirect_to @course, notice: "Aguardando confirmação pagamento."
    end


  end

  private

  def load_params
    params.require(:order).permit(:pay_type)
  end
end
