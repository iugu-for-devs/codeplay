class Admins::LessonsController < Admins::ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
  end
end
