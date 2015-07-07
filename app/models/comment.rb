class Comment < ActiveRecord::Base
  # Record versioning
  has_paper_trail

  # Has many relationships
  has_many :votes, as: :votable

  # Belongs to these models
  belongs_to :user
  belongs_to :course

  # Self association
  has_many :replies, class_name: "Comment",
    foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Comment",
    foreign_key: "parent_id"

  before_create :init_rank

  validates :content, length: { maximum: 5000 }, presence: true
  validates_associated :parent
  validates_associated :course

  private

  def init_rank
    self[:rank] = (DateTime.now.to_i - 1134028003) / 45000 * (10**8)
  end
end
