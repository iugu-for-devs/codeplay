class AddSubscriptionRefToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :subscription, null: true, foreign_key: true
  end
end
