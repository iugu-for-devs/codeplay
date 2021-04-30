class TextLessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_lesson

  def show; end

  def check_done
    current_user.text_lesson_statuses.find_by(text_lesson_id: @lesson).done!
    redirect_to [@lesson.course, @lesson]
  end

  def uncheck_done
    current_user.text_lesson_statuses.find_by(text_lesson_id: @lesson).undone!
    redirect_to [@lesson.course, @lesson]
  end

  private

  def fetch_lesson
    @lesson = TextLesson.find(params[:id])
  end
end
