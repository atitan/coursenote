class Entry < ActiveRecord::Base
  # Belongs to these models
  belongs_to :course, touch: true

  validates_presence_of :course, :department
  validates :timetable, json: { schema: Rails.root.join('app', 'models', 'schemas', 'time_filter.json').to_s }

  def self.time_str_to_table(str)
    output = {}

    str.each do |x|
      tmp = /([1-7])-([1-8ABCDEFG]+)/.match(x)
      next if tmp.nil?

      day = tmp[1].to_i
      section = tmp[2].split('')
      output[day] = section
    end

    output
  end
end
