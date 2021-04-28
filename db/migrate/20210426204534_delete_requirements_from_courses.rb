class DeleteRequirementsFromCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :requirements, :string
  end
end
