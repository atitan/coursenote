class Course < ActiveRecord::Base
  # Validations
  validates_presence_of :title, :category

  # Has many relationships
  has_many :comments, -> { thread.order(score: :desc, created_at: :desc) }
  has_many :votes, as: :votable
  has_many :entries

  scope :available_only, -> { where(available: true) }
  scope :by_title, -> title { where('title LIKE ?', "%#{title}%") }
  scope :by_instructor, -> instructor { where('instructor LIKE ?', "%#{instructor}%") }
  scope :by_department, -> department { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where('entries.department LIKE ?', "%#{department}%").uniq }
  scope :by_category, -> category { where(category: category) }
  scope :by_code, -> code { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where(entries: { code: code }).uniq }
  scope :by_time, -> time { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where("entries.timetable <@ ? and entries.timetable <> '{}'", time.to_json).uniq }
  scope :hide_by_title, -> title { where.not(title: title) }
  scope :cross_department, -> { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where(entries: { cross_department: true }).uniq }
  scope :optional, -> { joins('RIGHT JOIN entries ON courses.id = entries.course_id').where(entries: { required: false }).uniq }
  scope :order_by_rating, -> { order(engaged: :desc, score: :desc, votes_count: :desc, id: :asc) }

  after_touch :check_engagement

  def check_engagement
    return if engaged
    return unless comments.empty? || votes.empty?

    update(engaged: true)
  end
end
