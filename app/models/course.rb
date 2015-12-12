class Course < ActiveRecord::Base
  # Validations
  validates_presence_of :title, :category

  # Has many relationships
  has_many :comments, -> { thread.order(score: :desc, created_at: :desc) }
  has_many :votes, as: :votable
  has_many :entries

  scope :available_only, -> { where(available: true) }
  scope :by_title, -> title { where('title LIKE ?', "%#{title}%") }
  scope :by_instructor, -> instructor { where('instructor LIKE ?', "%#{instructor}%") }
  scope :by_department, -> department { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where('entries.department LIKE ?', "%#{department}%").uniq }
  scope :by_category, -> category { where(category: category) }
  scope :by_code, -> code { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where(entries: {code: code}).uniq }
  scope :by_time, -> time { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where('entries.timetable <@ ?', time.to_json).where('entries.timetable <> ?', {}.to_json).uniq }
  scope :hide_by_title, -> title { where.not(title: title) }
  scope :cross_department, -> { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where(entries: {cross_department: true}).uniq }
end
