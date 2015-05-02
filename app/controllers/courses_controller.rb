class CoursesController < ApplicationController

  #has_scope :available, type: :boolean, allow_blank: true
  #has_scope :required, type: :boolean, allow_blank: true
  has_scope :by_title
  has_scope :by_instructor
  has_scope :by_department
  has_scope :by_category, type: :array
  has_scope :page, default: 1

  def index
    @courses = apply_scopes(Course).includes(:entries).all

    raise ActiveRecord::RecordNotFound if @courses.empty?
  end

  def show
    @course = Course.includes(:entries, :comments).find(params[:id])
    @new_comment = current_user.comments.new if user_signed_in?
  end

end
