class CheckCommentForCourseEngagement < ActiveRecord::Migration[4.2]
  def change
    rename_column :courses, :received_vote, :engaged

    Course.joins(:comments).distinct.update_all(engaged: true)
  end
end
