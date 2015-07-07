class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false
      t.integer :parent_id
      t.integer :score, null: false, default: 0
      t.integer :rank, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :course_id
    add_index :comments, :parent_id
    add_index :comments, :score
    add_index :comments, :rank
  end
end
