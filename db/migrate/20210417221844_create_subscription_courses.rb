class CreateSubscriptionCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :subscription_courses do |t|
      t.references :course, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
