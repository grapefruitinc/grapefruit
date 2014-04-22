class Webwork::User < ActiveRecord::Base
	use_connection_ninja(:webwork)

	# Returns whether a webwork record has been
	# created for a specific user, course, and model
	def self.missing_records?(course, user)
		self.set_table_name_using_course(course, "user")
		return true unless self.where(user_id: user.unique_tag).count > 0

		self.set_table_name_using_course(course, "password")
		return true unless self.where(user_id: user.unique_tag).count > 0

		self.set_table_name_using_course(course, "permission")
		return true unless self.where(user_id: user.unique_tag).count > 0

		return false
	end

	def self.extract_course_from_url(url)
		# Expects a URL like: http://webwork2.cs.rpi.edu/webwork2/myTestCourse/Orientation/
		# and returns myTestCourse
		return url.split("/")[4]
	end

	def self.set_table_name_using_course(course, tbl_name=nil)
		course_name = self.extract_course_from_url(course.webwork_url)
		tbl_name = self.name.demodulize.downcase unless tbl_name.present?
		self.table_name = "#{course_name}_#{tbl_name}"
	end

	def self.create_from_course_and_user(course, user)
		self.set_table_name_using_course(course, "user")
		if self.where(user_id: user.unique_tag).count == 0
			self.new(user_id: user.unique_tag, first_name: user.first_name, last_name: user.last_name, email_address: user.email, student_id: user.unique_tag, status: "C", section: nil, recitation: nil, comment: nil).save
		end

		self.set_table_name_using_course(course, "password")
		if self.where(user_id: user.unique_tag).count == 0
			self.new(user_id: user.unique_tag, password: user.encrypted_password.crypt((0..9).to_a.sample.to_s + ('A'..'Z').to_a.sample.to_s)).save
		end

		self.set_table_name_using_course(course, "permission")
		if self.where(user_id: user.unique_tag).count == 0
			self.new(user_id: user.unique_tag, permission: 1).save
		end
	end

end
