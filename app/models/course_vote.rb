class CourseVote < ActiveRecord::Base
  # Belongs to these models
  belongs_to :course
  belongs_to :user
end
