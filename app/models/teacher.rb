class Teacher < ActiveRecord::Base
  # Has many relationships
  has_many :courses
end
