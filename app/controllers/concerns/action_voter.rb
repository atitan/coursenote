module ActionVoter
  extend ActiveSupport::Concern

  def vote_for(votable, choice)
    vote = current_user.votes.find_or_initialize_by(votable: votable)
    if vote.update(upvote: choice)
      render json: vote.as_json(
        only: [:id, :votable_id, :votable_type, :upvote, :updated_at],
        include: { votable: { only: [:score, :votes_count] } }
      )
    else
      render json: { error: vote.errors.full_messages }, status: 500
    end
  end
end
