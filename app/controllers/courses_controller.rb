class CoursesController < ApplicationController
  include ActionVoter

  before_action :authenticate_user!, only: :vote

  has_scope :by_title
  has_scope :by_instructor
  has_scope :by_category, type: :array
  has_scope :by_department
  has_scope :page, default: 1
  has_scope :cross_department, type: :boolean
  has_scope :show_all, default: false, type: :boolean, allow_blank: true do |_controller, scope, value|
    value ? scope : scope.available_only
  end
  has_scope :hide_passed_courses, type: :boolean, if: :user_signed_in? do |controller, scope|
    scope.hide_by_title(controller.current_user.passed_courses)
  end
  has_scope :apply_time_filter, type: :boolean, if: :user_signed_in? do |controller, scope|
    scope.by_time(controller.current_user.time_filter)
  end

  def index
    @courses = apply_scopes(Course).includes(:entries, comments: :replies).order(received_vote: :desc, score: :desc, votes_count: :desc, id: :asc)
    @new_comment = Comment.new
    @votes = current_user.votes if user_signed_in?
  end

  def show
    @course = Course.includes(:entries, comments: :replies).find(params[:id])
    @new_comment = Comment.new
  end

  def vote
    course = Course.find(params[:course_id])
    vote_it(course, params[:upvote])
  end
end
