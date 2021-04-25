class AddPriceToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :price, :decimal, precision: 10, scale: 2
  end
end
