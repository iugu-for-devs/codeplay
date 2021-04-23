class AddTokenToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :token, :string
  end
end
