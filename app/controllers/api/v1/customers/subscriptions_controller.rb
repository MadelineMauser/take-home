class SubscriptionsController < ApplicationController
  def create
    new_subscription = Subscription.new(subscription_params, customer_id: params[:id])
    if new_subscription.save
      
    end
  end
end

private 

def subscription_params
  params.require(:subscription).permit(:title, :price, :status, :frequency)
end