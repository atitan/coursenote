class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  after_save :update_rank

  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type]

  private

  def update_rank
    seconds = (votable.created_at.to_i - 1134028003) / 45000 if votable_type == "Comment"
    rank_f = compute_rank(seconds)
    rank = Integer(10**8 * rank_f)

    votable.update(rank: rank)
  end

  def compute_rank(seconds = 0)
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

    (sign*order+seconds).round(8)
  end
end
