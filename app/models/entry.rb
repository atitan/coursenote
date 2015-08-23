class Entry < ActiveRecord::Base
  # Belongs to these models
  belongs_to :course
  
  validates_presence_of :course, :department
end