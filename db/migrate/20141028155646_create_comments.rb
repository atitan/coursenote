class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :parent_id
      t.integer :rank
      t.text :content
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :course_id
    add_index :comments, :parent_id
    add_index :comments, :rank
    add_index :comments, :deleted_at
  end
end
