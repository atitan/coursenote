module ActionVoter
  extend ActiveSupport::Concern

  def vote_it(votable, choice)
    vote = current_user.votes.find_or_initialize_by(votable: votable)
    if vote.update(upvote: choice)
      render json: vote.as_json(
        include: { votable: { only: [:score, :votes_count] } }
      )
    else
      render json: { error: vote.errors.full_messages }, status: 500
    end
  end
end
