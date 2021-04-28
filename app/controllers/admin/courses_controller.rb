class Admin::CoursesController < Admin::ApplicationController
  before_action :set_course, only: %i[show search_courses requirements add_requirement delete_requirement]

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
      redirect_to [:admin, @course], notice: 'Curso criado com sucesso.'
    else
      render :new
    end
  end

  def requirements; end

  def search_courses
    @courses = Course.search(params[:name])
                     .where.not(id: @course.requirements.ids)
                     .where.not(id: @course)
    render :requirements
  end

  def add_requirement
    @course.requirements << Course.find(params[:course_id])

    redirect_to requirements_admin_course_path
  end

  def delete_requirement
    @requirement = Course.find(params[:requirement_id])
    @course.requirements.delete(@requirement)

    redirect_to requirements_admin_course_path
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params
      .require(:course)
      .permit(:name, :description, :instructor, :cover)
  end
end
