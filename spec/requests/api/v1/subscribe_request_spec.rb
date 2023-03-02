require 'rails_helper'

RSpec.describe "Subscribe", type: :request do
  before :all do
    
  end
  describe "POST /api/v1/subscribe" do
    it "successfully creates a customer_subscription" do
      post '/api/v1/subscribe', params: {customer_id: , subscription_id: }
      expect(response).to have_http_status(200)
    end
  end
end
