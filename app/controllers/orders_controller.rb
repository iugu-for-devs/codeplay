class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_params, only: [:create]
  before_action :load_product

  def new
    @order = Order.new
  end

  def create
    @order = if params[:subscription_id]
               Order.new(subscription: @product,
                         user: current_user,
                         pay_type: load_params[:pay_type])
             else
               Order.new(course: @product,
                         user: current_user,
                         pay_type: load_params[:pay_type])
             end

    push_invoice
  end

  private

  def load_params
    params.require(:order).permit(:pay_type)
  end

  def load_product
    @product = if params[:subscription_id]
                 Subscription.find(params[:subscription_id])
               else
                 Course.find(params[:course_id])
               end
  end

  def push_invoice
    @order.send_invoice_request
    @order.save

    return redirect_to @product, notice: t('.success') if @order.approved?

    return redirect_to @product, notice: 'Aguardando confirmação pagamento.' if @order.status == 'pending'
  end
end
