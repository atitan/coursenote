class CreateEntries < ActiveRecord::Migration
   def change
    create_table :entries do |t|
      t.integer :course_id
      t.string :course_code, null: false
      t.string :timetable, null: false
      
      t.timestamps null: false
    end

    add_index :entries, :course_id
    add_index :entries, :course_code
  end
end
