class SubscriptionsController < ApplicationController
  def create
    new_subscription = Subscription.new(subscription_params, customer_id: params[:id])
    if new_subscription.save
      params[:tea_ids].each do |tea_id|
        new_subscription.tea_subscriptions.create(tea_id: tea_id)
      end
      
    end
  end
end

private 

def subscription_params
  params.require(:subscription).permit(:title, :price, :status, :frequency)
end