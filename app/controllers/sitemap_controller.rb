class SitemapController < ApplicationController
  layout nil

  def course
    @most_recent = Course.select(:updated_at).order(updated_at: :desc).limit(1).first
    if stale?(etag: @most_recent, last_modified: @most_recent.updated_at.utc.rfc822)
      respond_to do |format|
        format.xml { @courses = Course.select(:id, :updated_at) }
      end
    end
  end
end
