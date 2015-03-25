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
  belongs_to :school_account
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

    CourseUser.import course_users, validate: false
  end

  def remove_student(student)
    self.course_users.where(user: student).destroy_all
  end

  def course_user(user)
    self.course_users.find_by_user_id(user)
  end

  def perfect_total
    self.assignments.inject(0) { |sum, assignment| sum += assignment.points }
  end

  # Outputting
  # ========================================================
  def seats_left
    "#{self.students.count} / #{self.spots_available}"
  end

end
