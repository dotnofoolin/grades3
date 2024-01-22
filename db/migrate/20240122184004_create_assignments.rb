class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.references :student, index: true
      t.references :course, index: true
      t.datetime :due_date
      t.datetime :date_assigned
      t.string :name
      t.string :category
      t.float :score
      t.float :total_points
      t.timestamps
    end

    add_foreign_key :assignments, :students
    add_foreign_key :assignments, :courses
  end
end
