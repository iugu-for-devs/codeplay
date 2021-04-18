class OrdersController < ApplicationController
  def new
    @course = Course.find(params[:course])
    @order = Order.new
  end

  def create
    @course = Course.find(params[:course])
    @order = Order.create

    if params[:pay_type].blank?
      flash.now[:notice] = 'Pay type não pode ficar em branco'
      return render :new
    end

    redirect_to @course, notice: 'Compra realizada com sucesso!'
  end
end
