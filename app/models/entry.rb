class Entry < ActiveRecord::Base
  # Belongs to these models
  belongs_to :course
  
  validates_presence_of :course, :department
  validates :timetable, json: { schema: Rails.root.join('app', 'models', 'schemas', 'time_filter.json').to_s }
end