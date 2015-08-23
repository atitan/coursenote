class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :lockable, :confirmable, :encryptable

  # Has many relationships
  has_many :comments
  has_many :votes

  before_create :check_identity
  before_save :sanitize_passed_courses

  def student?
    self[:is_student]
  end

  def check_identity
    exp = /\A((s|g)(\d{7,8})@cycu\.edu\.tw)\z/i
    self[:is_student] = !self[:email].match(exp).nil?
    true
  end

  def sanitize_passed_courses
    self[:passed_courses].uniq!
  end

  def active_for_authentication?
    super && (self[:banned_until].nil? || DateTime.now > self[:banned_until])
  end
end