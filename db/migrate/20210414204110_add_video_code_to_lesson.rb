class AddVideoCodeToLesson < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :video_code, :string
  end
end
