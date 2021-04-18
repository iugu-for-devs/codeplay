class OrdersController < ApplicationController
  def new
    @course = Course.find(params[:course])
    @order = Order.new
  end

  def create
    @course = Course.find(params[:course])
    @order = Order.new(pay_type: params[:pay_type])

    return redirect_to @course, notice: 'Compra realizada com sucesso!' if @order.save

    flash.now[:notice] = @order.errors.full_messages
    return render :new
  end
end
