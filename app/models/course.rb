# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  instructor_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Course < ActiveRecord::Base

	validates :name, presence: true

	belongs_to :instructor, class_name: "User"
  has_many :course_users, dependent: :destroy
  has_many :students, class_name: "User", through: :course_users, source: :user
  has_many :capsules, dependent: :destroy

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

end
