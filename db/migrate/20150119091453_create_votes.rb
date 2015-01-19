class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :votable_id
      t.string :votable_type
      t.integer :user_id
      t.boolean :upvote

      t.timestamps null: false
    end

    add_index :votes, :votable_id
  end
end
