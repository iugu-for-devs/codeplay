class Admin::LessonsController < Admin::ApplicationController
  before_action :fetch_lesson, only: %i[show edit update destroy]
  before_action :set_course, only: %i[new create]

  def show; end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.new(lesson_params)
    if @lesson.save
      redirect_to [:admin, @lesson.course, @lesson]
    else
      render :new
    end
  end

  def edit; end

  def update
    if @lesson.update(lesson_params)
      flash[:notice] = t('.success')
      redirect_to [:admin, @lesson.course, @lesson]
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    flash[:notice] = t('.success', lesson_name: @lesson.name)
    redirect_to admin_course_path(@lesson.course.id)
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def lesson_params
    params.require(:lesson).permit(:name, :description, :video_code)
  end

  def fetch_lesson
    @lesson = Lesson.find(params[:id])
  end
end
