class SubscriptionsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  before_action :set_subscription, only: %i[show search_course]

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
      flash[:now] = @subscription.errors.full_messages
      render :new
    end
  end

  def show; end

  def search_course
    @subscription = Subscription.find(params[:id])
    @courses = Course.search(params[:name])
    render :show
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
