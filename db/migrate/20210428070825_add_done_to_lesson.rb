class AddDoneToLesson < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :done, :integer, default: 10
  end
end
