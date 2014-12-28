class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :category, null: false
      t.string :department, null: false
      t.string :instructor, null: false
      t.integer :credit, null: false, default: 0
      t.integer :rank, null: false, default: 0
      t.boolean :required, null: false
      t.boolean :quittable, null: false
      t.boolean :cross_department, null: false
      t.boolean :cross_graduate, null: false
      t.text :note

      t.timestamps
    end

    add_index :courses, :title
    add_index :courses, :category
    add_index :courses, :department
    add_index :courses, :instructor
    add_index :courses, :credit
    add_index :courses, :rank
    add_index :courses, :required
    add_index :courses, :quittable
    add_index :courses, :cross_department
    add_index :courses, :cross_graduate
  end
end
