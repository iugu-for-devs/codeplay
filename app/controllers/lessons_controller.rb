class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_lesson

  def show
    @lesson = Lesson.find(params[:id])
  end

  def check_done
    @lesson.check!
    redirect_to [@lesson.course, @lesson]
  end

  def uncheck_done
    @lesson.uncheck!
    redirect_to [@lesson.course, @lesson]
  end

  private

  def fetch_lesson
    @lesson = Lesson.find(params[:id])
  end
end
