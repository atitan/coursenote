class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :category, null: false
      t.string :instructor, null: false
      t.integer :rank, null: false, default: 0
      t.boolean :available, null: false
      t.timestamps
    end

    add_index :courses, :title
    add_index :courses, :category
    add_index :courses, :instructor
    add_index :courses, :rank
  end
end
