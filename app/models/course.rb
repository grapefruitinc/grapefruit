# == Schema Information
#
# Table name: courses
#
#  id                         :integer          not null, primary key
#  name                       :string(255)
#  created_at                 :datetime
#  updated_at                 :datetime
#  instructor_id              :integer
#  description                :string(255)
#  subject                    :string(255)
#  course_number              :string(255)
#  course_registration_number :string(255)
#  semester                   :string(255)
#  year                       :integer
#  spots_available            :integer
#  credits                    :integer
#

class Course < ActiveRecord::Base
  
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
  has_many :documents, dependent: :destroy
  has_many :topics, dependent: :destroy

  # Student definitions
  # ========================================================
  def add_student(student)
    add_students([student])
  end

  def add_students(students_to_add)
    course_users = []

    students_to_add.each do |student|
      if student.valid?
        unless self.students.include?(student)
          course_users.push CourseUser.new(user_id: student.id, course_id: self.id)
        end
      end
    end

    CourseUser.import course_users, validate: false unless course_users.empty?
  end

  def course_user(user)
    course_users.find_by_user_id(user)
  end

  # Outputting
  # ========================================================
  def seats_left
    "#{self.students.count} / #{self.spots_available}"
  end

end
