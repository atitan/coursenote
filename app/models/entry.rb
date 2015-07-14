class Entry < ActiveRecord::Base
  # Belongs to these models
  belongs_to :course
  
  # Has many relationships
  has_many :favorite_courses

  validates_presence_of :course

  def time
    day = 0
    offset = %w(A 1 2 3 4 B 5 6 7 8 C D E F G H)
    output = ''

    # convert timetable back to text
    self[:timetable].scan(/\d{16}/) do |x|
      day += 1
      next if x.to_i(2) == 0

      output << day.to_s + '-'
      x.split('').map(&:to_i).each_with_index do |item, index|
        output << offset[index] if item != 0
      end
      output << ' '
    end
    
    output
  end
end