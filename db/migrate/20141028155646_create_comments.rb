class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :parent_id
      t.integer :rank
      t.text :content

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :course_id
    add_index :comments, :parent_id
    add_index :comments, :rank
  end
end
