class TextLessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    @lesson = TextLesson.find(params[:id])
  end
end
