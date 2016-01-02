class CheckCommentForCourseEngagement < ActiveRecord::Migration
  def change
    rename_column :courses, :received_vote, :engaged

    Course.joins(:comments).uniq.update_all(engaged: true)
  end
end
