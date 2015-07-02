class CoursesController < ApplicationController

  before_action :authenticate_user!, only: :vote

  #has_scope :available, type: :boolean, allow_blank: true
  #has_scope :required, type: :boolean, allow_blank: true
  has_scope :by_title
  has_scope :by_instructor
  has_scope :by_department
  has_scope :by_category, type: :array
  has_scope :page, default: 1

  def index
    @courses = apply_scopes(Course).includes(:entries)

    raise ActiveRecord::RecordNotFound if @courses.empty?
  end

  def show
    @course = Course.includes(:entries, :comments).find(params[:id])
    @new_comment = current_user.comments.new if user_signed_in?
  end

  def vote
    course = Course.find(params[:course_id])
    vote = current_user.votes.find_or_initialize_by(votable: course)
    if vote.update(vote_params)
      render plain: 'ok'
    else
      render plain: 'error', status: 500
    end
  end

  private

  def vote_params
    params[:upvote] = nil if params[:upvote] == 'nil'
    {upvote: params[:upvote]}
  end

end
