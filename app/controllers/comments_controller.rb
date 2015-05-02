class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_comment, only: [:update, :destroy]

  def create
    current_user.comments.create(comment_params)
  end

  def update
    @comment.update_attibutes(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def find_comment
    @comment = current_user.comments.find_by(id: params[:id])
    raise ActiveRecord::RecordNotFound if @comment.nil?
  end

  def comment_params
    params.require(:comment).permit(:course_id, :parent_id, :content)
  end
end
