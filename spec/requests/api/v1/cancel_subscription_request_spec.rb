require 'rails_helper'

RSpec.describe "Update Subscription", type: :request do
  before :all do
    @customer_1 = Customer.new(first_name: 'Fred', last_name: 'Williams', email: 'fredw@example.com', address: '123 Example Place')
    @tea_1 = Tea.new(title: 'Spicy Chai', description: 'Extra spicy with cinnamon.', temperature: 212, brew_time: 4)
    @tea_2 = Tea.new(title: 'Uncommon Chai', description: 'Uses a secret blend of spices.', temperature: 200, brew_time: 3)
    @subscription_1 = Subscription.new(customer_id: @customer_1.id, title: 'Chai Delight', price: 20, frequency: 3)
    @tea_subscription_1 = TeaSubscription.new(tea_id: @tea_1.id, subscription_id: @subscription_1.id)
    @tea_subscription_2 = TeaSubscription.new(tea_id: @tea_2.id, subscription_id: @subscription_1.id)
  end
  describe "PATCH /api/v1/subscription/<id>/cancel" do
    it "successfully changes a subscription status to 'cancelled'" do
      expect(Subscription.first.status).to eq('active')

      patch "/api/v1/subscription/#{@subscription_1.id}/cancel"

      expect(response).to have_http_status(200)
      expect(Subscription.first.status).to eq('cancelled')
    end
  end
end
