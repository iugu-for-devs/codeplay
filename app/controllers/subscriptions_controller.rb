class SubscriptionsController < ApplicationController
    def index
       @subscriptions = Subscription.all
    end

    def new
      @subscription = Subscription.new
    end

    def create
      @subscription = Subscription.new(subscription_params)
      if @subscription.save
        redirect_to subscriptions_path, alert: 'Plano cadastrado com sucesso'
      else
        render :new
      end
    end

    def show
      @subscription = Subscription.find(params[:id])
    end

    private

      def subscription_params
        params
          .require(:subscription)
          .permit(:name, :description, :price)
      end
end