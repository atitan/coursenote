class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :category, null: false
      t.string :instructor, null: false
      t.integer :score, null: false, default: 0
      t.boolean :available, null: false, default: true
      t.timestamps
    end

    add_index :courses, :title
    add_index :courses, :category
    add_index :courses, :instructor
    add_index :courses, :score
    add_index :courses, :available
  end
end
