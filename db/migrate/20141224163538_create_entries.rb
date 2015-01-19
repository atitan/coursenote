class CreateEntries < ActiveRecord::Migration
   def change
    create_table :entries do |t|
      t.integer :course_id
      t.string :code, null: false
      t.string :timetable, null: false
      t.boolean :cross_department, null: false
      t.boolean :cross_graduate, null: false
      t.text :note
      
      t.timestamps null: false
    end

    add_index :entries, :course_id
    add_index :entries, :code
    add_index :entries, :cross_department
    add_index :entries, :cross_graduate
  end
end
