class Comment < ActiveRecord::Base
  # Soft delete
  acts_as_paranoid

  # Has many relationships
  has_many :comment_votes
  has_many :replies, class_name: "Comment",
    foreign_key: "parent_id", dependent: :destroy

  # Belongs to these models
  belongs_to :user
  belongs_to :course
  belongs_to :parent, class_name: "Comment",
    foreign_key: "parent_id"


end
