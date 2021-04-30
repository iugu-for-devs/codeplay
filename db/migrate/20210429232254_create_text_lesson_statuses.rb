class CreateTextLessonStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :text_lesson_statuses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :text_lesson, null: false, foreign_key: true
      t.integer :status, default: 10

      t.timestamps
    end
  end
end
