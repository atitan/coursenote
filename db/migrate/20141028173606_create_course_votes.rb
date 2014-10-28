class CreateCourseVotes < ActiveRecord::Migration
  def change
    create_table :course_votes do |t|
      t.integer :user_id
      t.integer :course_id
      t.boolean :upvote

      t.timestamps
    end

    add_index :course_votes, [:user_id, :course_id], unique: true
    add_index :course_votes, :course_id
  end
end
