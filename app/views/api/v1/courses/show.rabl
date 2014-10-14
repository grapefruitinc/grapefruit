object @course

attributes :id, :name, :description, :credits, :subject, :course_number

child :announcements do
  attributes :title, :content
end

child :instructor => :instructor do
  attributes :name, :email
end

child :capsules do
  attributes :id, :name
end