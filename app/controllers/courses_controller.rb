class CoursesController < ApplicationController
  layout 'home'
  before_action :set_course, only: %i[show]

  def index
    @courses = Course.all
  end

  def show; end

  private

  def set_course
    @course = Course.find(params[:id])
  end
end
