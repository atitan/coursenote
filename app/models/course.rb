class Course < ActiveRecord::Base
  # Has many relationships
  has_many :comments
  has_many :votes, as: :votable
  has_many :entries
  has_many :terms

  scope :available, -> (value = false){ where(available: value) } 
  scope :required, -> (value = false) { where(required: value) }
  scope :by_title, -> search { where("title LIKE ?", "%#{search}%") }
  scope :by_instructor, -> search { where("instructor LIKE ?", "%#{search}%") }
  scope :by_department, -> search { where("department LIKE ?", "%#{search}%") }
  scope :by_category, -> search { where(category: search) }

end
