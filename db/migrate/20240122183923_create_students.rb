class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :student_id
      t.string :name
      t.timestamps
    end
  end
end
