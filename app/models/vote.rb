class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  after_save :update_score
  after_save :update_rank

  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]
  validates_associated :votable

  private

  def update_score
    history = changes['upvote']
    lookup = { nil => 0, true => 1, false => -1 }

    diff = -lookup[history[0]] + lookup[history[1]]
    votable.update(score: votable.score + diff)
  end

  def update_rank
    return true unless votable_type == "Comment" and votable.is_parent?

    ballots = Vote.where(votable: votable)

    counted = Hash.new(0)
    ballots.each { |ballot| counted[ballot[:upvote]] += 1 }

    # Reference: Reddit Ranking Algorithm
    s = counted[true] - counted[false]
    order = Math.log10([s.abs, 1].max)

    case s
    when s > 0
      sign = 1
    when s < 0
      sign = -1
    else
      sign = 0
    end

    seconds = (votable.created_at.to_i - 1134028003) / 45000
    rank = Integer(10**8 * (sign*order+seconds).round(8))
    votable.update(rank: rank)
  end
end
