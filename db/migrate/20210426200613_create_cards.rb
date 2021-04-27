class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :token
      t.string :name
      t.string :last_digits
      t.string :expiration_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
