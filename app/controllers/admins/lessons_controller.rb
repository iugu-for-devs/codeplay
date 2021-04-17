class Admins::LessonsController < Admins::ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      redirect_to admins_lesson_path(@lesson)
    else
      render :new
    end
  end
end

private

def lesson_params
  params.require(:lesson).permit(:name, :description, :video_code, :course_id)
end
