class CoursesController < ApplicationController
  before_action :set_course, only: %i[show]

  def index
    @courses = Course.all
  end

  def show; end

  def add
    @subscription = Subscription.find(params[:id])
    @course = Course.find(params[:course_id])
    return redirect_to @subscription, alert: 'Curso não encontrado' unless @course

    if @subscription.courses.include?(@course)
      redirect_to @subscription, alert: 'Curso já cadastrado nesta assinatura'
    else
      @subscription.courses << @course
      redirect_to @subscription, alert: 'Curso cadastrado com sucesso'
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
