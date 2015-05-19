class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_comment, only: [:update, :destroy]

  def create
    current_user.comments.create(create_params)
    redirect_to course_path params[:comment][:course_id]
  end

  def update
    @comment.update_attibutes(update_params)
  end

  def destroy
    @comment.destroy
  end

  def vote
    comment = Comment.find(params[:comment_id])
    vote = current_user.votes.find_or_initialize_by(votable: comment)
    vote.update_attributes(vote_params)
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
    params.require(:vote).permit(:upvote)
    params[:vote][:upvote] = nil if params[:vote][:upvote] == 'nil'
  end

end
