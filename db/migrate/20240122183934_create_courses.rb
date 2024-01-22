class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.references :student, index: true
      t.string :name
      t.float :average
      t.datetime :last_update
      t.timestamps
    end

    add_foreign_key :courses, :students
  end
end
