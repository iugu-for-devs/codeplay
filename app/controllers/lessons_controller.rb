class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    @lesson = Lesson.find(params[:id])
  end
end
