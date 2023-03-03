require 'rails_helper'

RSpec.describe "Get Customer Subscriptions", type: :request do
  before :all do
    @customer_1 = Customer.new(first_name: 'Fred', last_name: 'Williams', email: 'fredw@example.com', address: '123 Example Place')
    @customer_2 = Customer.new(first_name: 'Irma', last_name: 'Redd', email: 'irmar@example.com', address: '456 Example Way')
    @tea_1 = Tea.new(title: 'Spicy Chai', description: 'Extra spicy with cinnamon.', temperature: 212, brew_time: 4)
    @tea_2 = Tea.new(title: 'Uncommon Chai', description: 'Uses a secret blend of spices.', temperature: 200, brew_time: 3)
    @tea_3 = Tea.new(title: 'Morning Black', description: 'Black tea with high caffeine.', temperature: 212, brew_time: 4)
    @tea_4 = Tea.new(title: 'English Breakfast', description: 'Classic breakfast tea.', temperature: 200, brew_time: 3)
    @subscription_1 = Subscription.new(customer_id: @customer_1.id, title: 'Chai Delight', price: 20, frequency: 3)
    @subscription_2 = Subscription.new(customer_id: @customer_1.id, title: 'Dawn Risers', price: 20, frequency: 3)
    @subscription_3 = Subscription.new(customer_id: @customer_2.id, title: 'Solo Chai', price: 20, frequency: 3)
    @tea_subscription_1 = TeaSubscription.new(tea_id: @tea_1.id, subscription_id: @subscription_1.id)
    @tea_subscription_2 = TeaSubscription.new(tea_id: @tea_2.id, subscription_id: @subscription_1.id)
    @tea_subscription_3 = TeaSubscription.new(tea_id: @tea_3.id, subscription_id: @subscription_2.id)
    @tea_subscription_4 = TeaSubscription.new(tea_id: @tea_4.id, subscription_id: @subscription_2.id)
    @tea_subscription_5 = TeaSubscription.new(tea_id: @tea_1.id, subscription_id: @subscription_3.id)
  end
  describe "GET /api/v1/customers/<id>/subscriptions" do
    it "Retrieves all subscriptions for a customer" do
      @subscription_1.status = 'cancelled'

      get "/api/v1/customers/#{@customer_1.id}/subscriptions"

      returned_subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(returned_subscriptions).to be_a(Hash)
      expect(returned_subscriptions[:data]).to be_an(Array)
      expect(returned_subscriptions[:data].size).to eq(2)
      expect(returned_subscriptions[:data].first[:id]).to eq(@subscription_1.id.to_s)
      expect(returned_subscriptions[:data].last[:id]).to eq(@subscription_2.id.to_s)
      expect(returned_subscriptions[:data].first[:attributes]).to be_a(Hash)
      expect(returned_subscriptions[:data].first[:attributes][:customer_id]).to eq(@customer_1.id)
      expect(returned_subscriptions[:data].last[:attributes][:customer_id]).to eq(@customer_1.id)
      expect(returned_subscriptions[:data].first[:attributes][:title]).to eq(@subscription_1.title)
      expect(returned_subscriptions[:data].first[:attributes][:price]).to eq(@subscription_1.price)
      expect(returned_subscriptions[:data].first[:attributes][:frequency]).to eq(@subscription_1.frequency)
      expect(returned_subscriptions[:data].first[:attributes][:created_at].to_date).to eq(@subscription_1.created_at.to_date)
      expect(returned_subscriptions[:data].first[:attributes][:teas].length).to eq(2)
      expect(returned_subscriptions[:data].first[:attributes][:teas].first[:id]).to eq(@tea_1.id.to_s)
    end
  end
end