class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_lesson

  def show
    @lesson = Lesson.find(params[:id])
  end

  def check_done
    @lesson.check!
  end

  def uncheck_done
    @lesson.uncheck!
  end

  private

  def fetch_lesson
    @lesson = Lesson.find(params[:id])
  end
end
