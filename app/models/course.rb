# == Schema Information
#
# Table name: courses
#
#  id                         :integer          not null, primary key
#  name                       :string(255)
#  instructor_id              :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  description                :text(65535)
#  subject                    :string(255)
#  course_number              :string(255)
#  course_registration_number :string(255)
#  semester                   :string(255)
#  year                       :integer
#  spots_available            :integer
#  credits                    :integer
#  slug                       :string(255)
#  problem_set_url            :text(65535)
#  school_account_id          :integer
#  instructor_label           :string(255)
#

class Course < ActiveRecord::Base
  extend FriendlyId

  # Validations
  # ========================================================
  validates_presence_of :name, :description, :subject, :course_number,
                        :course_registration_number, :semester, :year

  validates :spots_available, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :credits, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Relationships
  # ========================================================
  belongs_to :school_account

  has_many :course_users, dependent: :destroy
  has_many :student_course_users, -> { where role: CourseUser::STUDENT }, class_name: 'CourseUser'
  has_many :instructor_course_users, -> { where role: CourseUser::INSTRUCTOR }, class_name: 'CourseUser'
  has_many :assistant_course_users, -> { where role: CourseUser::ASSISTANT }, class_name: 'CourseUser'
  has_many :students, class_name: 'User', through: :student_course_users, source: :user
  has_many :instructors, class_name: 'User', through: :instructor_course_users, source: :user
  has_many :assistants, class_name: 'User', through: :assistant_course_users, source: :user

  has_many :capsules, dependent: :destroy
  has_many :lectures, through: :capsules
  has_many :documents, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :assignment_types, dependent: :destroy
  has_many :announcements, dependent: :destroy

  # Friendly_id definitions
  # ========================================================
  friendly_id :name, use: [:slugged, :finders, :history]

  def slug_candidates
    [
      :name#,
      #[:name, :professor],
      #[:name, :professor, :semester]
    ]
  end

  # Helper methods
  # ========================================================

  def add_student(student)
    add_students([student])
  end

  def add_students(students_to_add)
    add_users(students_to_add, CourseUser::STUDENT)
  end

  def add_assistant(assistant)
    add_assistants([assistant])
  end

  def add_assistants(assistants_to_add)
    add_users(assistants_to_add, CourseUser::ASSISTANT)
  end

  def add_instructor(instructor)
    add_instructors([instructor])
  end

  def add_instructors(instructors_to_add)
    add_users(instructors_to_add, CourseUser::INSTRUCTOR)
  end

  def add_users(users_to_add, role)
    course_users = []

    users_to_add.each do |user|
      if user.valid? && !self.has?(user)
        course_users.push CourseUser.new(user: user, course: self, role: role)
      end
    end

    CourseUser.import course_users, validate: false
  end

  def remove_student(student)
    self.student_course_users.where(user: student).destroy_all
  end

  def remove_assistant(assistant)
    self.assistant_course_users.where(user: assistant).destroy_all
  end

  def remove_instructor(instructor)
    if self.instructors.count > 1
      self.instructor_course_users.where(user: instructor).destroy_all
    end
  end

  def course_user(user)
    self.course_users.find_by_user_id(user)
  end

  def perfect_total
    self.assignments.inject(0) { |sum, assignment| sum += assignment.points }
  end

  # the user either instructs, assists with, or is enrolled in the course
  def has?(user)
    self.edited_by?(user) || user.enrolled?(self)
  end

  # the user either instructs or assists with the course
  def edited_by?(user)
    user.instructs?(self) || user.assists?(self)
  end

  # Outputting
  # ========================================================
  def seats_left
    "#{self.students.count} / #{self.spots_available}"
  end

end
