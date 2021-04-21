class Admin::SubscriptionsController < Admin::ApplicationController
  before_action :set_subscription, only: %i[show]
  def index
    @subscriptions = Subscription.all
  end

  def show; end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      redirect_to [:admin, @subscription], alert: 'Plano cadastrado com sucesso'
    else
      flash[:now] = @subscription.errors.full_messages
      render :new
    end
  end

  def search_course
    @subscription = Subscription.find(params[:id])
    @courses = Course.search(params[:name])
    render :show
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params
      .require(:subscription)
      .permit(:name, :description, :price)
  end
end
