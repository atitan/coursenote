class Comment < ActiveRecord::Base
  # Record versioning
  has_paper_trail

  # Has many relationships
  has_many :votes, as: :votable

  # Belongs to these models
  belongs_to :user
  belongs_to :course

  # Self association
  has_many :replies, -> { order(:created_at) }, class_name: 'Comment',
    foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment',
    foreign_key: 'parent_id'

  validates :content, length: { maximum: 5000 }, presence: true
  validates_presence_of :course, :user
  validates_presence_of :parent, unless: 'parent_id.nil?'
  validate :check_parent_course_id, unless: 'parent_id.nil?'

  scope :thread, -> { where(parent: nil) }

  def check_parent_course_id
    errors.add(:course_id, 'different course_id between parent and reply') if parent.course_id != course_id
  end
end