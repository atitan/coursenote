class AddCommentsCountToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :comments_count, :integer, default: 0

    Course.pluck(:id).each do |i|
      Course.reset_counters(i, :comments)
    end
  end
end
