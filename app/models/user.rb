# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  can_create_courses     :boolean          default(FALSE)
#  school_account_id      :integer
#

class User < ActiveRecord::Base

  # Devise
  # ========================================================
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  # Relationships
  # ========================================================
  has_many :instructed_courses, class_name: "Course", foreign_key: "instructor_id"

  has_many :course_users, dependent: :destroy
  has_many :student_courses, class_name: "Course", through: :course_users, source: :course, dependent: :destroy

  has_many :replies, foreign_key: "author_id"
  has_many :topics, foreign_key: "author_id"
  has_many :grades, foreign_key: "user_id"

  belongs_to :school_account

  # Validations
  # ========================================================
  validates :school_account, presence: { message: " must be selected, and a valid option. Don't see your school? Contact hello@grapefruit.link." }

  # User Types
  # ========================================================
  def self.unassigned
    User.where.not(id: includes(:student_courses)).where.not(id: includes(:instructed_courses))
  end

  def self.instructors
    joins(:instructed_courses).uniq
  end

  def self.students
    includes(:student_courses)
  end

  def grade_for_course(course)
    (self.grades.joins(:assignment).merge(Assignment.where(course_id: course.id)).sum(:points) / course.perfect_total * 100).round(2).to_s + "%"
  end

  # Output
  # ========================================================
  def display_identifier
    !self.name.blank? ? self.first_name : self.email
  end

  def first_name
    self.name.split(" ").first
  end

  def last_name
    self.name.split(" ").last
  end

  def first_initial_last_name
    self.first_name[0].downcase + self.last_name.downcase
  end

  def unique_tag
    "#{self.first_initial_last_name}_#{self.id}"
  end

  def full_name
    self.name.blank? ? self.email : self.name
  end

  def as_json(options)
    { display_identifier: display_identifier }
  end

end
