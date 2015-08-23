class CreateEntries < ActiveRecord::Migration
   def change
    create_table :entries do |t|
      t.integer :course_id, null: false
      t.string :code, null: false
      t.integer :credit, null: false, default: 0
      t.string :department, null: false
      t.jsonb :timetable, null: false
      t.string :timestring, null: false
      t.boolean :cross_department, null: false
      t.boolean :cross_graduate, null: false
      t.boolean :quittable, null: false
      t.boolean :required, null: false
      t.string :note, null: false, default: ''
      
      t.timestamps null: false
    end

    add_index :entries, :course_id
    add_index :entries, :code
    add_index :entries, :department
    add_index :entries, :timetable, using: 'gin'
  end
end
