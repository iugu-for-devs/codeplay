class AddTokenToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :token, :string
  end
end
