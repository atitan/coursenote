class FavoriteCourse < ActiveRecord::Base
  # Belongs to these models
  belongs_to :user
  belongs_to :course_entry
end
