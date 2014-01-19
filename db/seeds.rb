# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create(name: "Michael Bluth", email: "michael@bluth.com", password: "password", is_admin: true)

professor_one = User.create(name: "Buster Bluth", email: "buster@bluth.com", password: "password")
professor_two = User.create(name: "Gob Bluth", email: "gob@bluth.com", password: "password")
professor_three = User.create(name: "Tobias Funke", email: "tobias@bluth.com", password: "password")

student_one = User.create(name: "Maebe Funke", email: "maebe@bluth.com", password: "password")
student_two = User.create(name: "George-Michael Bluth", email: "georgemichael@bluth.com", password: "password")
student_three = User.create(name: "Steve Holt", email: "steve@bluth.com", password: "password")

course_one = Course.create(name: "Introduction to Illusions", instructor: professor_two)
  Capsule.create(name: "Illusion vs. Tricks", course: course_one)
  Capsule.create(name: "The Gothic Castle", course: course_one)
  capsule_one = Capsule.create(name: "Magician Secrets", course: course_one)
    Lecture.create(name: "Never Reveal Your Secrets!", lecture_number: 1, capsule: capsule_one)
course_two = Course.create(name: "Basics of Cartography", instructor: professor_one)
  capsule_two = Capsule.create(name: "Paper Mapmaking", course: course_two)
    Lecture.create(name: "Blue Means Water", lecture_number: 1, capsule: capsule_two)
    Lecture.create(name: "Green Means Land", lecture_number: 2, capsule: capsule_two)
course_three = Course.create(name: "Acting 101", instructor: professor_three)
  Capsule.create(name: "How to Act", course: course_three)
course_four = Course.create(name: "Advanced Acting II: Blue Theories", instructor: professor_three)
  Capsule.create(name: "Music of the Blue Man Group", course: course_four)

CourseUser.create(course: course_one, user: student_one)
CourseUser.create(course: course_one, user: student_two)
CourseUser.create(course: course_one, user: student_three)
CourseUser.create(course: course_two, user: student_two)
CourseUser.create(course: course_three, user: student_one)
CourseUser.create(course: course_three, user: student_three)