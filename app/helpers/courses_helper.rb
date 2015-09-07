module CoursesHelper
  def time_overlap?(timetable, current_user)
    return '' if current_user.nil?
    time_filter = current_user.time_filter
    nonoverlap = time_filter.empty? || timetable.keys.all?{|key| time_filter.has_key?(key) && (timetable[key] - time_filter[key]).empty?}
    nonoverlap ? '' : 'background-color: #FFCCCC'
  end

  def vote_course_btns(course)
    if course.voted(current_user) == []
      html =  button_to course_vote_path(course_id: course.id, upvote: true), class: 'btn btn-success mg-t-10 btn-vote-course', form_class: 'btn-vote-course button_to', 'aria-label': '推', method: :post, remote: true do
                concat content_tag :span, '', class: 'fa fa-thumbs-o-up', 'aria-hidden': 'true'
                concat raw "&ensp;推"
              end
      html += button_to course_vote_path(course_id: course.id, upvote: false), class: 'btn btn-danger mg-t-10 btn-vote-course', form_class: 'btn-vote-course button_to', 'aria-label': '噓', method: :post, remote: true do
                concat content_tag :span, '', class: 'fa fa-thumbs-o-down', 'aria-hidden': 'true'
                concat raw "&ensp;噓"
              end
    elsif course.voted(current_user).first.upvote == true
      html =  button_to course_vote_path(course_id: course.id, upvote: true), disabled: true, class: 'btn btn-success mg-t-10 btn-vote-course', form_class: 'btn-vote-course button_to', 'aria-label': '推', method: :post, remote: true do
                concat content_tag :span, '', class: 'fa fa-thumbs-o-up', 'aria-hidden': 'true'
                concat raw "&ensp;推"
              end
      html += button_to course_vote_path(course_id: course.id, upvote: false), class: 'btn btn-danger mg-t-10 btn-vote-course', form_class: 'btn-vote-course button_to', 'aria-label': '噓', method: :post, remote: true do
                concat content_tag :span, '', class: 'fa fa-thumbs-o-down', 'aria-hidden': 'true'
                concat raw "&ensp;噓"
              end
    elsif course.voted(current_user).first.upvote == false
      html =  button_to course_vote_path(course_id: course.id, upvote: true), class: 'btn btn-success mg-t-10 btn-vote-course', form_class: 'btn-vote-course button_to', 'aria-label': '推', method: :post, remote: true do
                concat content_tag :span, '', class: 'fa fa-thumbs-o-up', 'aria-hidden': 'true'
                concat raw "&ensp;推"
              end
      html += button_to course_vote_path(course_id: course.id, upvote: false), disabled: true, class: 'btn btn-danger mg-t-10 btn-vote-course', form_class: 'btn-vote-course button_to', 'aria-label': '噓', method: :post, remote: true do
                concat content_tag :span, '', class: 'fa fa-thumbs-o-down', 'aria-hidden': 'true'
                concat raw "&ensp;噓"
              end
    end
  end
end
