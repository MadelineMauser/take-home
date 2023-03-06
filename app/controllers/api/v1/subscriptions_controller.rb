class Api::V1::SubscriptionsController < ApplicationController
  def create
    current_customer = Customer.find(params[:customer_id])
    new_subscription = current_customer.subscriptions.new(subscription_params)
    new_subscription[:status] = 'active'
    if new_subscription.save
      params[:tea_ids].each do |tea_id|
        new_subscription.tea_subscriptions.create(tea_id: tea_id)
      end
      render json: SubscriptionSerializer.new(new_subscription)
    else
      render json: {error: new_subscription.errors.full_messages.join(", ")}, status: 400
    end
  end
end

private 

def subscription_params
  params.require(:subscription).permit(:title, :price, :status, :frequency)
end