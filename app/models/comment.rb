class Comment < ActiveRecord::Base
  # Record versioning
  has_paper_trail

  # Has many relationships
  has_many :votes, as: :votable
  has_many :replies, class_name: "Comment",
    foreign_key: "parent_id", dependent: :destroy

  # Belongs to these models
  belongs_to :user
  belongs_to :course
  belongs_to :parent, class_name: "Comment",
    foreign_key: "parent_id"

  validates :content, length: { maximum: 5000 }, presence: true
end
