class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_comment, only: [:update, :destroy]

  def create
    current_user.comments.create(comment_params)
    redirect_to course_path params[:comment][:course_id]
  end

  def update
    @comment.update_attibutes(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def find_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:course_id, :parent_id, :content)
  end
end
