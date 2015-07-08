class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :lockable, :confirmable

  # Has many relationships
  has_many :comments
  has_many :votes
  has_many :favorite_courses

  def student_id
    return false unless student?
    self[:email].match(/\A((s|g)(\d{7,8})@cycu\.edu\.tw)\z/i)[3]
  end

  def student?
    !self[:email].match(/\A((s|g)\d{7,8}@cycu\.edu\.tw)\z/i).nil?
  end
end
