class CreateEntries < ActiveRecord::Migration
   def change
    create_table :entries do |t|
      t.integer :course_id
      t.string :code, null: false
      t.integer :credit, null: false, default: 0
      t.string :department, null: false
      t.string :timetable, null: false
      t.boolean :cross_department, null: false
      t.boolean :cross_graduate, null: false
      t.boolean :quittable, null: false
      t.boolean :required, null: false
      t.text :note
      
      t.timestamps null: false
    end

    add_index :entries, :course_id
    add_index :entries, :code
    add_index :entries, :credit
    add_index :entries, :department
    add_index :entries, :required
    add_index :entries, :timetable
    add_index :entries, :quittable
    add_index :entries, :cross_department
    add_index :entries, :cross_graduate
  end
end
