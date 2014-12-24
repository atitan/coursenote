class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title, null: false, default: ""
      t.string :category
      t.string :department
      t.string :instructor
      t.integer :credit, null: false, default: 0
      t.integer :rank, null: false, default: 0
      t.boolean :required

      t.timestamps
    end

    add_index :courses, :title
    add_index :courses, :category
    add_index :courses, :department
    add_index :courses, :instructor
    add_index :courses, :credit
    add_index :courses, :rank
    add_index :courses, :required
  end
end
