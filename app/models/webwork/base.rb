class Webwork::Base < ActiveRecord::Base
	use_connection_ninja(:webwork)

	# Returns whether a webwork record has been
	# created for a specific user, course, and model
	def self.exists?(user, course)
		# return true unless self.env.production?

		course_name = self.extract_course_from_url(course.webwork_url)
		self.table_name = "#{course_name}_#{self.name.demodulize.downcase}"
		
		self.where(user_id: user.id).count > 0
	end

	def self.extract_course_from_url(url)
		# Expects a URL like: http://webwork2.cs.rpi.edu/webwork2/myTestCourse/Orientation/
		# and returns myTestCourse
		return url.split("/")[4]
	end

end