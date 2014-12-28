class Course < ActiveRecord::Base
  # Has many relationships
  has_many :comments
  has_many :course_votes
  has_many :course_entries
  has_many :terms

  default_scope -> { order(title: :desc) }
  scope :required, -> { where(required: true) }
  scope :by_title, -> search { where("title LIKE ?", "%#{search}%") }
  scope :by_instructor, -> search { where("instructor LIKE ?", "%#{search}%") }
  scope :by_department, -> search { where("department LIKE ?", "%#{search}%") }
  scope :by_category, -> search { where("category LIKE ?", "%#{search}%") }

end
