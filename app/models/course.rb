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
  scope :by_category, -> search { where(category: search) }
  scope :hide_passed_courses, -> passed_courses { where.not(title: passed_courses) }
end
