# == Schema Information
#
# Table name: courses
#
#  id                         :integer          not null, primary key
#  name                       :string(255)
#  instructor_id              :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#  description                :text
#  subject                    :string(255)
#  course_number              :string(255)
#  course_registration_number :string(255)
#  semester                   :string(255)
#  year                       :integer
#  spots_available            :integer
#  credits                    :integer
#  slug                       :string(255)
#  webwork_url                :string(255)
#  problem_set_url            :text
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
  belongs_to :instructor, class_name: "User"
  has_many :course_users, dependent: :destroy
  has_many :students, class_name: "User", through: :course_users, source: :user
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

  # Student definitions
  # ========================================================
  def add_student(student)
    add_students([student])
  end

  def add_students(students_to_add)
    course_users = []

    students_to_add.each do |student|
      if (student.valid? && !self.students.include?(student))
        course_users.push CourseUser.new(user_id: student.id, course_id: self.id)
      end
    end

    CourseUser.import course_users, validate: false unless course_users.empty?
  end

  def remove_student(student)
    CourseUser.where(user_id: student.id, course_id: self.id).destroy_all
  end

  def course_user(user)
    course_users.find_by_user_id(user)
  end

  def perfect_total
    sum = 0
    self.assignments.each do |assignment|
      sum += assignment.points
    end
    sum
  end

  # Outputting
  # ========================================================
  def seats_left
    "#{self.students.count} / #{self.spots_available}"
  end

  # Ensures that all webwork records needed exist for this course and a specific user
  def ensure_webwork_exists(user)
    return false unless self.webwork_url.present?

    if Webwork::User.missing_records?(self, user)
      Webwork::User.create_from_course_and_user(self, user)
    end
  end

end
