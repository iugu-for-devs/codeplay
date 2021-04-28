class AddRequirementsToCourses < ActiveRecord::Migration[6.1]
  def change
    add_reference :courses, :requirement, foreign_key: {to_table: :courses}
  end
end
