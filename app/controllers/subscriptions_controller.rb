class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: %i[show]

  def index
    @subscriptions = Subscription.all
  end

  def show; end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
