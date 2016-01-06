class SitemapController < ApplicationController
  layout nil

  def course
    @most_recent = Course.select(:updated_at).limit(1).order(updated_at: :desc).first
    if stale?(etag: @most_recent, last_modified: @most_recent.updated_at.utc)
      respond_to do |format|
        format.xml { @courses = Course.select(:id, :updated_at) }
      end
    end
  end
end
