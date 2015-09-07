class Course < ActiveRecord::Base
  # Validations
  validates_presence_of :title, :category

  # Has many relationships
  has_many :comments, -> { thread.order(score: :desc, created_at: :desc) }
  has_many :votes, as: :votable
  has_many :entries

  scope :available_only, -> { where(available: true) }
  scope :by_title, -> search { where('title LIKE ?', "%#{search}%") }
  scope :by_instructor, -> search { where('instructor LIKE ?', "%#{search}%") }
  scope :by_department, -> search { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where('entries.department LIKE ?', "%#{search}%").uniq }
  scope :cross_department, -> { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where(entries: {cross_department: true}).uniq }
  scope :by_category, -> search { where(category: search) }
  scope :hide_passed_courses, -> passed_courses { where.not(title: passed_courses) }
  scope :apply_time_filter, -> time_filter { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where('entries.timetable <@ ?', time_filter.to_json).where('entries.timetable <> ?', {}.to_json).uniq }

  def voted(user)
    user ||= User.new
    self.votes.where(user_id: user.id)
  end
end
