class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]
end
