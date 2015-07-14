class CreatePassedCourses < ActiveRecord::Migration
  def change
    create_table :passed_courses do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false

      t.timestamps null: false
    end

    add_index :passed_courses, [:user_id, :course_id], unique: true
    add_index :passed_courses, :user_id
    add_index :passed_courses, :course_id
  end
end
