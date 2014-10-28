class Course < ActiveRecord::Base
  # Has many relationships
  has_many :comments
  has_many :course_votes
  has_many :schedules
  has_many :terms

end
