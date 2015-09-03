class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:update, :destroy]

  def create
    if @comment = current_user.comments.create(comment_params)
      # render json: comment
      render 'courses/comments/created'         if  @comment.parent_id.nil?
      render 'courses/comments/replies/created' if !@comment.parent_id.nil?
    else
      render json: { error: @comment.errors.full_messages }, status: :internal_server_error
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: { error: @comment.errors.full_messages }, status: :internal_server_error
    end
  end

  def destroy
    if @comment.destroy
      render json: @comment
    else
      render json: { error: @comment.errors.full_messages }, status: :internal_server_error
    end
  end

  def vote
    comment = Comment.find(params[:comment_id])
    vote = current_user.votes.find_or_initialize_by(votable: comment)
    if vote.update(vote_params)
      render json: vote
    else
      render json: { error: vote.errors.full_messages }, status: :internal_server_error
    end
  end

  private

  def find_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params_allowed = [:content]
    params_allowed << :course_id << :parent_id if action_name == 'create'
    params.require(:comment).permit(params_allowed)
  end

  def vote_params
    params[:upvote] = nil if params[:upvote] == 'nil'
    { upvote: params[:upvote] }
  end
end
