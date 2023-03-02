require 'rails_helper'

RSpec.describe "Subscribe", type: :request do
  before :all do
    @customer_1 = Customer.new(first_name: 'Fred', last_name: 'Williams', email: 'fredw@example.com', address: '123 Example Place')
    @tea_1 = Tea.new(title: 'Spicy Chai', description: 'Extra spicy with cinnamon.', temperature: 212, brew_time: 4)
    @tea_2 = Tea.new(title: 'Uncommon Chai', description: 'Uses a secret blend of spices.', temperature: 200, brew_time: 3)
  end
  describe "POST /api/v1/subscribe" do
    it "successfully creates a subscription with teas" do
      post '/api/v1/subscribe', params: {
        subscription: {
          customer_id: @customer_1.id,
          title: 'Chai Delight',
          price: 20,
          frequency: 3
        }
        tea_ids: [@tea_1.id, @tea_2.id]
      }
      expect(response).to have_http_status(200)
    end
  end
end
