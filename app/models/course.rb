class Course < ActiveRecord::Base
  # Has many relationships
  has_many :comments, -> { thread.order(score: :desc, created_at: :desc) }
  has_many :votes, as: :votable
  has_many :entries

  default_scope { where(available: true) }
  scope :show_all, -> { unscope(where: :available) }
  scope :by_title, -> search { where("title LIKE ?", "%#{search}%") }
  scope :by_instructor, -> search { where("instructor LIKE ?", "%#{search}%") }
  scope :by_department, -> search { joins("RIGHT JOIN entries ON courses.id = entries.course_id").where("entries.department LIKE ?", "%#{search}%").uniq }
  scope :by_category, -> search { where(category: search) }

end
