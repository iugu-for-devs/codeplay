class AddUniqCourseIdAndSubscriptionIdtoSubscriptionCourses < ActiveRecord::Migration[6.1]
  def change
    add_index :subscription_courses, [:course_id, :subscription_id], unique: true
  end
end
