class AddCourseRefToTextLesson < ActiveRecord::Migration[6.1]
  def change
    add_reference :text_lessons, :course, null: false, foreign_key: true
  end
end
