class CreateFavoriteCourses < ActiveRecord::Migration
  def change
    create_table :favorite_courses do |t|
      t.integer :user_id
      t.integer :course_entry_id

      t.timestamps null: false
    end

    add_index :favorite_courses, :user_id
    add_index :favorite_courses, :course_entry_id
  end
end
