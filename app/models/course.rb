class Course < ActiveRecord::Base
  # Has many relationships
  has_many :comments
  has_many :course_votes
  has_many :schedules
  has_many :terms

  # Belongs to these models
  belongs_to :course_category
  belongs_to :department
  belongs_to :teacher

end
