class HomeController < ApplicationController
  layout 'home'

  def index
    @courses = Course.all
    @users = User.all
    @subscriptions = Subscription.all
  end
end
