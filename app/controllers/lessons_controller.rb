class LessonsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @lesson = Lesson.find(params[:id])
  end
end
