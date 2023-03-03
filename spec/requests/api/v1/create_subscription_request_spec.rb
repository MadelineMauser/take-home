require 'rails_helper'

RSpec.describe "Subscription", type: :request do
  before :all do
    @customer_1 = Customer.new(first_name: 'Fred', last_name: 'Williams', email: 'fredw@example.com', address: '123 Example Place')
    @tea_1 = Tea.new(title: 'Spicy Chai', description: 'Extra spicy with cinnamon.', temperature: 212, brew_time: 4)
    @tea_2 = Tea.new(title: 'Uncommon Chai', description: 'Uses a secret blend of spices.', temperature: 200, brew_time: 3)
  end
  describe "POST /api/v1/subscription" do
    it "successfully creates a subscription with teas" do
      post '/api/v1/subscription', params: {
        subscription: {
          customer_id: @customer_1.id,
          title: 'Chai Delight',
          price: 20,
          frequency: 3
        }
        tea_ids: [@tea_1.id, @tea_2.id]
      }

      expect(response).to have_http_status(200)
      expect(Subscription.count).to eq(1)
      expect(Subscription.first.customer_id).to eq(@customer_1.id)
      expect(Subscription.first.title).to eq('Chai Delight')
      expect(Subscription.first.price).to eq(20)
      expect(Subscription.first.frequency).to eq(3)
      expect(Subscription.first.teas).to eq([@tea_1, @tea_2])
    end
  end
end