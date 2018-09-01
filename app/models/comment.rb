class Comment < ApplicationRecord
  # Record versioning
  has_paper_trail only: :content, meta: { user_id: :user_id,
                                          course_id: :course_id,
                                          parent_id: :parent_id }

  # Has many relationships
  has_many :votes, as: :votable

  # Belongs to these models
  belongs_to :user
  belongs_to :course, touch: true

  # Self association
  has_many :replies, -> { order(:created_at) }, class_name: 'Comment',
            foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Comment',
              foreign_key: 'parent_id', optional: true

  validates :content, length: { maximum: 1000 }, presence: true
  validates_presence_of :course, :user
  validates_presence_of :parent, unless: 'parent_id.nil?'
  validate :check_parent_course_id, unless: 'parent.nil?'

  scope :thread, -> { where(parent: nil) }

  before_create :generate_avatar

  def generate_avatar
    self[:avatar] = Digest::MD5.hexdigest("#{course_id}-#{user.secure_random}")
  end

  def check_parent_course_id
    if parent.course_id != course_id
      errors.add(:course_id, 'id不相符')
    end
  end
end
