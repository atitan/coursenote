module CoursesHelper
  def time_overlap?(timetable, current_user)
    return '' if current_user.nil?
    time_filter = current_user.time_filter
    nonoverlap = time_filter.empty? || timetable.keys.all?{|key| time_filter.has_key?(key) && (timetable[key] - time_filter[key]).empty?}
    nonoverlap ? '' : 'background-color: #FFCCCC'
  end

  def vote_course_status(votes, course_id, btn_type)
    return false if votes.blank?

    vote = votes.find do |vote|
      vote[:votable_type] == 'Course'.freeze && vote[:votable_id] == course_id
    end

    if vote.nil?
      false
    elsif vote.upvote == btn_type
      true
    else
      false
    end
  end
end
