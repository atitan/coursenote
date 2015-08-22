class Course < ActiveRecord::Base
  # Validations
  validates :title,      presence: { message: "課程名稱不得為空" }
  validates :category,   presence: { message: "課程類別不得為空" }
  validates :instructor, presence: { message: "課程教師不得為空" }


  # Has many relationships
  has_many :comments, -> { thread.order(score: :desc, created_at: :desc) }
  has_many :votes, as: :votable
  has_many :entries
  has_many :passed_courses

  scope :available_only, -> { where(available: true) }
  scope :by_title, -> search { where('title LIKE ?', "%#{search}%") }
  scope :by_instructor, -> search { where('instructor LIKE ?', "%#{search}%") }
  scope :by_department, -> search { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where('entries.department LIKE ?', "%#{search}%").uniq }
  scope :by_category, -> search { where(category: search) }
  scope :hide_passed_courses, -> passed_courses { where.not(id: passed_courses) }
end
