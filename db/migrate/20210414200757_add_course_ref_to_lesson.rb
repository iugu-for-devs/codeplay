class AddCourseRefToLesson < ActiveRecord::Migration[6.1]
  def change
    add_reference :lessons, :course, null: false, foreign_key: true
  end
end
