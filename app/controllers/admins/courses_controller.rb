class Admins::CoursesController < Admins::ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course =  Course.find(params[:id])
  end
end
