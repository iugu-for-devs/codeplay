class AddFieldsToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :instructor, :string
    add_column :courses, :cover, :string
    add_column :courses, :requirements, :string
    add_reference :courses, :admin, null: false, foreign_key: true
  end
end
