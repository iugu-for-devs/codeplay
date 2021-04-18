class Admins::LessonsController < Admins::ApplicationController
  before_action :fetch_lesson, only: %i[show edit update destroy]

  def show; end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      redirect_to_lesson_show
    else
      render :new
    end
  end

  def edit; end

  def update
    if @lesson.update(lesson_params)
      flash[:notice] = 'Aula atualizada com sucesso'
      redirect_to_lesson_show
    else
      render :edit
    end
  end

  def destroy
    course_id = @lesson.course_id
    @lesson.destroy
    flash[:notice] = "Aula #{@lesson.name} apagada com sucesso"
    redirect_to_course_index(course_id)
  end
end

private

def lesson_params
  params.require(:lesson).permit(:name, :description, :video_code, :course_id)
end

def fetch_lesson
  @lesson = Lesson.find(params[:id])
end

def redirect_to_lesson_show
  redirect_to admins_lesson_path(@lesson)
end

def redirect_to_course_index(course_id)
  redirect_to admins_course_path(Course.find(course_id))
end
