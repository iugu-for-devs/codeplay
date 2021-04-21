class Admin::CoursesController < Admin::ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course =  Course.find(params[:id])
  end

  def add
    @subscription = Subscription.find(params[:id])
    @course = Course.find(params[:course_id])
    return redirect_to [:admin, @subscription], alert: 'Curso não encontrado' unless @course

    if @subscription.courses.include?(@course)
      redirect_to [:admin, @subscription], alert: 'Curso já cadastrado nesta assinatura'
    else
      @subscription.courses << @course
      redirect_to [:admin, @subscription], alert: 'Curso cadastrado com sucesso'
    end
  end
end
