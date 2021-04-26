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
    
    response = @order.send_invoice_request

    if response? 'Aprovado'
      return redirect_to @course, notice: t('Compra efetuada com sucesso') if @order.save
    end
    
    if @order.status.eql? 'pending'
      return redirect_to @course, notice: t('Fatura enviada para seu email.') if @order.save
    end

    if @order.status.eql? 'refused'
      flash.now[:error] = 'Fatura não pode ser gerada tente novamente'
      render :new
    end    
  end
end
