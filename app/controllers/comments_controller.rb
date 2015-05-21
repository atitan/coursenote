class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_comment, only: [:update, :destroy]

  def create
    if current_user.comments.create(create_params)
      render plain: 'ok'
    else
      render plain: 'error', status: 500
  end

  def update
    if @comment.update(update_params)
      render plain: 'ok'
    else
      render plain: 'error', status: 500
  end

  def destroy
    if @comment.destroy
      render plain: 'ok'
    else
      render plain: 'error', status: 500
  end

  def vote
    comment = Comment.find(params[:comment_id])
    vote = current_user.votes.find_or_initialize_by(votable: comment)
    if vote.update(vote_params)
      render plain: 'ok'
    else
      render plain: 'error', status: 500
  end

  private

  def find_comment
    @comment = current_user.comments.find(params[:id])
  end

  def create_params
    params.require(:comment).permit(:course_id, :parent_id, :content)
    course = Course.find(params[:comment][:course_id])
    course.comments.find(params[:comment][:parent_id]) unless params[:comment][:parent_id].to_s.empty?
  end

  def update_params
    params.require(:comment).permit(:content)
  end

  def vote_params
    params[:upvote] = nil if params[:upvote] == 'nil'
    {upvote: params[:upvote]}
  end

end
