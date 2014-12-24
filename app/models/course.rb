class Course < ActiveRecord::Base
  # Has many relationships
  has_many :comments
  has_many :course_votes
  has_many :course_entries
  has_many :terms

  scope :name_like, ->(search) { where("name LIKE ?", "%#{search}%") }

end
