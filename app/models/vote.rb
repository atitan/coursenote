class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  after_save :recalculate_rank

  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]


  private

  def recalculate_rank
    
  end
end
