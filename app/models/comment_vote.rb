class CommentVote < ActiveRecord::Base
  # Belongs to these models
  belongs_to :comment
  belongs_to :user
end
