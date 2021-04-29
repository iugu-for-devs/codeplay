class OrdersController < ApplicationController
  before_action :authenticate_user!
  def new
    @course = Course.find(params[:course])
    @order = Order.new
  end

  def create
    @course = Course.find(params[:course])
    
    @course.lessons.each do |lesson|
      LessonStatus.create(user: current_user, lesson: lesson)
    end



    @order = Order.new(course: @course,
                       user: current_user,
                       pay_type: params[:pay_type])

    @order.send_invoice_request

    return redirect_to @course, notice: t('.success') if @order.situation
  end
end
