class FavoriteCourse < ActiveRecord::Base
  # Belongs to these models
  belongs_to :user
  belongs_to :entry

  after_save :update_time_filter

  private

  def update_time_filter

  end
end
