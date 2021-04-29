class Admin::TextLessonsController < Admin::ApplicationController
  before_action :fetch_text_lesson, only: %i[show edit update destroy]

  def show; end

  def new
    @lesson = TextLesson.new
  end

  def create
    course = Course.find(params[:course_id])
    @lesson = course.text_lessons.new(lesson_params)
    if @lesson.save
      redirect_to [:admin, @lesson.course, @lesson]
    else
      render :new
    end
  end

  def edit; end

  def update
    if @lesson.update(lesson_params)
      redirect_to [:admin, @lesson.course, @lesson], notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    redirect_to admin_course_path(@lesson.course.id), notice: t('.success', lesson_name: @lesson.name)
  end

  private

  def lesson_params
    params.require(:text_lesson).permit(:name, :description, :lesson_body)
  end

  def fetch_text_lesson
    @lesson = TextLesson.find(params[:id])
  end
end
