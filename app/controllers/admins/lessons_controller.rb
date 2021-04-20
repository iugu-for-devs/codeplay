class Admins::LessonsController < Admins::ApplicationController
  before_action :fetch_lesson, only: %i[show edit update destroy]

  def show; end

  def new
    @lesson = Lesson.new
  end

  def create
    course = Course.find(params[:course_id])
    @lesson = course.lessons.new(lesson_params)
    if @lesson.save
      redirect_to [:admins, @lesson.course, @lesson]
    else
      flash[:notice] = @lesson.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @lesson.update(lesson_params)
      flash[:notice] = t('.success')
      redirect_to [:admins, @lesson.course, @lesson]
    else
      flash[:notice] = @lesson.errors.full_messages
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    flash[:notice] = t('.success', lesson_name: @lesson.name)
    redirect_to admins_course_path(@lesson.course.id)
  end

  private

  def lesson_params
    params.require(:lesson).permit(:name, :description, :video_code)
  end

  def fetch_lesson
    @lesson = Lesson.find(params[:id])
  end
end
