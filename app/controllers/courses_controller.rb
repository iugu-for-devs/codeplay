class CoursesController < ApplicationController
  before_action :set_course, only: %i[show]
  before_action :authenticate_admin!, only: %i[new create add]

  def index
    @courses = Course.all
  end

  def show; end

  def new
    @course = Course.new
  end

  def create
    @course = current_admin.courses.new(course_params)
    if @course.save
      redirect_to @course, notice: 'Curso criado com sucesso.'
    else
      render :new
    end
  end

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

  def course_params
    params
      .require(:course)
      .permit(:name, :description, :instructor, :cover, :requirements)
  end
end
