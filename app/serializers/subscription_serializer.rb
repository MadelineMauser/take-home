class SubscriptionSerializer 
  include JSONAPI::Serializer
  attributes :title, :price, :status, :frequency, :customer_id, :teas, :created_at, :updated_at
end