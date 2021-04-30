class AddChangeDetailsToOrder < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:orders, :course_id, true)
  end
end
