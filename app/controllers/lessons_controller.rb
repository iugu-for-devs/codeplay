class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
  end
end
