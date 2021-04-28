class CreateTextLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :text_lessons do |t|
      t.string :name
      t.string :description
      t.string :lesson_body

      t.timestamps
    end
  end
end
