json.array! @courses do |course|
  json.cache! course do
    json.rating       course.score
    json.rating_count course.votes_count
    json.title        course.title
    json.instructor   course.instructor
    json.category     course.category
    json.created_at   course.created_at

    json.entries course.entries do |entry|
      json.code       entry.code
      json.timestring entry.timestring
      json.credit     entry.credit
      json.department entry.department
      json.note       entry.note
      json.capacity   entry.capacity
      json.created_at entry.created_at
    end

    json.comments course.comments do |comment|
      json.cache! comment do
        json.score        comment.score
        json.votes_count  comment.votes_count
        json.content      comment.content
        json.avatar       comment.avatar
        json.content      comment.content
        json.created_at   comment.created_at
        json.updated_at   comment.updated_at

        json.replies comment.replies do |reply|
          json.cache! reply do
            json.score        reply.score
            json.votes_count  reply.votes_count
            json.content      reply.content
            json.avatar       reply.avatar
            json.content      reply.content
            json.created_at   reply.created_at
            json.updated_at   reply.updated_at
          end
        end
      end
    end
  end
end