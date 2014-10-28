class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.integer :user_id
      t.integer :comment_id
      t.boolean :upvote

      t.timestamps
    end

    add_index :comment_votes, [:user_id, :comment_id], unique: true
    add_index :comment_votes, :comment_id
  end
end
