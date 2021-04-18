class SubscriptionsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create add_course]
  before_action :set_subscription, only: %i[show add_course]

  def index
    @subscriptions = Subscription.all
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to @subscription, alert: 'Plano cadastrado com sucesso'
    else
      render :new
    end
  end

  def show
  end

  def add_course
    @course = Course.find_by(name: params[:name])
    
    if @course.present?
      @subscription.courses << @course
      redirect_to @subscription, alert: 'Curso cadastrado com sucesso'
    else
      redirect_to @subscription, alert: 'Curso não encontrado'
    end
  end

  private

  def subscription_params
    params
      .require(:subscription)
      .permit(:name, :description, :price)
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
