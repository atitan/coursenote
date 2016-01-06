module SitemapHelper
  def frequency(time)
    if time > Date.today - 12.hours
      'hourly'
    elsif time > Date.today - 3.days
      'daily'
    elsif time > Date.today - 2.weeks
      'weekly'
    elsif time > Date.today - 6.months
      'monthly'
    else
      'yearly'
    end
  end
end
