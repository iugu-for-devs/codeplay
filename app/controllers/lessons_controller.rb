class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_lesson

  def show;end

  def check_done
    current_user.lesson_statuses.find_by(lesson_id: @lesson).done!
    redirect_to [@lesson.course, @lesson]
  end

  def uncheck_done
    current_user.lesson_statuses.find_by(lesson_id: @lesson).undone!
    redirect_to [@lesson.course, @lesson]
  end

  private

  def fetch_lesson
    @lesson = Lesson.find(params[:id])
  end
end
