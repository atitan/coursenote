class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false, default: ""
      t.integer :course_category_id
      t.integer :department_id
      t.integer :teacher_id
      t.integer :credit, null: false, default: 0
      t.string :code
      t.integer :rank, null: false, default: 0

      t.timestamps
    end

    add_index :courses, :name
    add_index :courses, :course_category_id
    add_index :courses, :department_id
    add_index :courses, :teacher_id
    add_index :courses, :credit
    add_index :courses, :code
    add_index :courses, :rank
  end
end
