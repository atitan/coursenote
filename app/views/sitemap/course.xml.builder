xml.instruct! :xml, version: '1.0'
xml.urlset('xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
  cache "courses/sitemap-#{@courses.size}-#{@most_recent.updated_at}" do
    @courses.each do |course|
      cache course do
        xml.url do
          xml.loc(course_url(course.id))
          xml.lastmod(course.updated_at)
          xml.changefreq(frequency(course.updated_at))
        end
      end
    end
  end
end