class TeaSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :tea

  validates_presence_of :tea_id, :subscription_id
end