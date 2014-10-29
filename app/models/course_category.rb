class CourseCategory < ActiveRecord::Base
  # Has many relationships
  has_many :courses
end
