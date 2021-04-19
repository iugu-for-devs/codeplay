class AddPayTypeToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :pay_type, :string
  end
end
