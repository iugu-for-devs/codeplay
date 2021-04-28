class AddNameToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :name, :string, null: false
  end
end
