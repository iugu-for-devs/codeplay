class Api::V1::OrdersController < ActionController::API
  def approve
    @order = Order.find_by(token: params[:token])
    @order.update(status: 'approved')
    head 200
  end
end
