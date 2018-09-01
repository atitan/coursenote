class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :lockable, :confirmable

  # Has many relationships
  has_many :comments
  has_many :votes

  before_create :check_identity
  before_create :generate_secure_random
  before_save :sanitize_array_column

  validates_length_of :passed_courses, maximum: 100
  validates_length_of :favorite_courses, maximum: 100
  validates :time_filter, json: { schema: Rails.root.join('app', 'models', 'schemas', 'time_filter.json').to_s }

  def student?
    self[:is_student]
  end

  # use randomly generated string to prevent identity guessing
  def generate_secure_random
    self[:secure_random] = SecureRandom.hex(16)
  end

  # extract student id
  def check_identity
    exp = /\A((s|g)(\d{7,8})@cycu\.edu\.tw)\z/i
    matches = self[:email].match(exp)
    self[:is_student] = !matches.nil?
    self[:student_id] = matches[3] if self[:is_student]
  end

  def sanitize_array_column
    self[:passed_courses].uniq!
    self[:favorite_courses].uniq!
    self[:passed_courses].reject!(&:blank?)
    self[:favorite_courses].reject!(&:blank?)
    self[:passed_courses].delete_if { |item| !item.is_a?(String) }
    self[:favorite_courses].delete_if { |item| !item.is_a?(String) }
  end

  def active_for_authentication?
    super && (self[:banned_until].nil? || DateTime.now > self[:banned_until])
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
