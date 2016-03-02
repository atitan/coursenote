class FixCourseEngagedStatus < ActiveRecord::Migration
  def change
    Course.update_all(engaged: false)
    
    Course.joins(:votes).uniq.update_all(engaged: true)
    Course.joins(:comments).uniq.update_all(engaged: true)
  end
end
