class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true, counter_cache: true, touch: true
  belongs_to :user

  after_save :update_score, if: :saved_change_to_upvote?

  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]
  validates_presence_of :votable, :user

  private

  def update_score
    history = saved_change_to_upvote
    lookup = { nil => 0, true => 1, false => -1 }

    diff = -lookup[history[0]] + lookup[history[1]]
    votable.update(score: votable.score + diff)
  end
end
