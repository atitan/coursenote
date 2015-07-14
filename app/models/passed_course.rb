class PassedCourse < ActiveRecord::Base
  # Belongs to these models
  belongs_to :user
  belongs_to :course

  validates_uniqueness_of :course_id, scope: :user_id
  validates_presence_of :user, :course
end