class AddPriceToSubscription < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions', :price, :decimal, null: false
  end
end
