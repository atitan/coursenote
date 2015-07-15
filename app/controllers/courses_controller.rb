class CoursesController < ApplicationController
  before_action :authenticate_user!, only: :vote

  has_scope :by_title
  has_scope :by_instructor
  has_scope :by_category, type: :array
  has_scope :by_department
  has_scope :page, default: 1
  has_scope :show_all do |controller, scope, value|
    value == "true" ? scope : scope.available_only
  end
  has_scope :hide_passed_courses, type: :boolean, if: :user_signed_in? do |controller, scope|
    scope.hide_passed_courses(controller.current_user.passed_courses)
  end

  def index
    @courses = apply_scopes(Course).includes(:entries).order(score: :desc)
  end

  def show
    @course = Course.includes(:entries, :comments).find(params[:id])
    @new_comment = current_user.comments.new if user_signed_in?
  end

  def vote
    course = Course.find(params[:course_id])
    vote = current_user.votes.find_or_initialize_by(votable: course)
    if vote.update(vote_params)
      render json: vote
    else
      render json: { error: vote.errors.full_messages }, status: :internal_server_error
    end
  end

  private

  def vote_params
    params[:upvote] = nil if params[:upvote] == 'nil'
    { upvote: params[:upvote] }
  end
end