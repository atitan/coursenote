class FixCourseEngagedStatus < ActiveRecord::Migration[4.2]
  def change
    Course.update_all(engaged: false)

    Course.joins(:votes).distinct.update_all(engaged: true)
    Course.joins(:comments).distinct.update_all(engaged: true)
  end
end
