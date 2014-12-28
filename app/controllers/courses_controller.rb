class CoursesController < ApplicationController

  has_scope :required, type: :boolean
  has_scope :by_title
  has_scope :by_instructor
  has_scope :by_department
  has_scope :by_category
  has_scope :page, default: 1

  def index
    @courses = apply_scopes(Course).all
  end

  def show
    @course = Course.find(params[:id])
  end

end
