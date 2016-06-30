class CommentsController < ApplicationController
  include ActionVoter

  before_action :authenticate_user!
  before_action :find_comment, only: [:update, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      @new_comment = Comment.new
      if @comment.parent_id.nil?
        render 'courses/comments/created'
      else
        render 'courses/comments/replies/created'
      end
    else
      render json: { error: @comment.errors.full_messages }, status: 500
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment.as_json(only: [:id, :content, :updated_at])
    else
      render json: { error: @comment.errors.full_messages }, status: 500
    end
  end

  def destroy
    if @comment.destroy
      render json: @comment.as_json(only: [:id])
    else
      render json: { error: @comment.errors.full_messages }, status: 500
    end
  end

  def vote
    comment = Comment.find(params[:comment_id])
    vote_for(comment, params[:upvote])
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
end
