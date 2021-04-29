class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :birthdate, :date
    add_column :users, :cpf, :string
    add_column :users, :address, :jsonb, null: false, default: {}
    add_index  :users, :address, using: :gin
  end
end
