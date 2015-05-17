class CreateFavoriteCourses < ActiveRecord::Migration
  def change
    create_table :favorite_courses do |t|
      t.integer :user_id, null: false
      t.integer :course_entry_id, null: false
      t.boolean :time_filter, null: false, default: false

      t.timestamps null: false
    end

    add_index :favorite_courses, :user_id
    add_index :favorite_courses, :course_entry_id
    add_index :favorite_courses, :time_filter
  end
end
