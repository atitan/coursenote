class FavoriteCourse < ActiveRecord::Base
  # Belongs to these models
  belongs_to :user
  belongs_to :entry

  after_save :update_time_filter

  validates_uniqueness_of :course_entry_id, scope: :user_id
  validates_presence_of :user, :entry

  private

  def update_time_filter
  end
end
