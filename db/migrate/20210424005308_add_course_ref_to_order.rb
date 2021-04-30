class AddCourseRefToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :course, null: false, foreign_key: true
  end
end
