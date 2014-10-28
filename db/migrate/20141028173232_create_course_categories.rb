class CreateCourseCategories < ActiveRecord::Migration
  def change
    create_table :course_categories do |t|
      t.string :name

      t.timestamps
    end

    add_index :course_categories, :name
  end
end
