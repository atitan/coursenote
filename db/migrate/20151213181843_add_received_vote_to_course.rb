class AddReceivedVoteToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :received_vote, :boolean, default: false, null: false
    change_column_default :courses, :available, false
    add_index :courses, :received_vote
    add_index :courses, :votes_count
    add_index :entries, :cross_department

    Course.where.not(votes_count: 0).update_all(received_vote: true)
  end
end
