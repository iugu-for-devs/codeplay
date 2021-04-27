class AddPaymentTokenToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :payment_token, :string
    add_index :users, :payment_token, unique: true
  end
end
