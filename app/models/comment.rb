class Comment < ActiveRecord::Base
  # Record versioning
  has_paper_trail

  # Has many relationships
  has_many :votes, as: :votable

  # Belongs to these models
  belongs_to :user
  belongs_to :course

  # Self association
  has_many :replies, -> { order(:created_at) }, class_name: "Comment",
    foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Comment",
    foreign_key: "parent_id"

  validates :content, length: { maximum: 5000 }, presence: true
  validates_associated :parent
  validates_associated :course

  scope :thread, -> { where(parent: nil) }
  
end
