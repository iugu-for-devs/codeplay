class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_course

  def new
    @order = Order.new
  end

  def create
    @course.lessons.each { |lesson| LessonStatus.create(user: current_user, lesson: lesson) }

    @course.text_lessons.each { |lesson| TextLessonStatus.create(user: current_user, text_lesson: lesson) }

    @order = Order.new(course: @course, user: current_user, pay_type: params[:pay_type])

    @order.send_invoice_request
    return redirect_to @course, notice: t('.success') if @order.situation
  end

  private

  def fetch_course
    @course = Course.find(params[:course])
  end
end
git