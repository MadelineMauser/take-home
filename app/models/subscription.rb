class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions

  validates_presence_of :title, :price, :status, :frequency, :customer_id
end