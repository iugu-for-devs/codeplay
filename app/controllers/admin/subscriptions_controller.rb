class Admin::SubscriptionsController < Admin::ApplicationController
  before_action :fetch_subscription, only: %i[show search_course add_course]

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
      redirect_to [:admin, @subscription], notice: t('.success')
    else
      flash[:now] = @subscription.errors.full_messages
      render :new
    end
  end

  def search_course
    @courses = Course.search(params[:name])
                     .where.not(id: @subscription.courses.ids)
    render :show
  end

  def add_course
    @course = Course.find(params[:course_id])
    @subscription.courses << @course
    redirect_to [:admin, @subscription], notice: t('.success')
  end

  private

  def fetch_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params
      .require(:subscription)
      .permit(:name, :description, :price)
  end
end
