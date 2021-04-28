class AddUniquenessVideoCodeToLesson < ActiveRecord::Migration[6.1]
  def change
    add_index :lessons, :video_code, unique: true
  end
end
