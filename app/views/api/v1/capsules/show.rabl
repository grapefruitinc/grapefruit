object @capsule

attributes :id, :name, :description, :course_id

child :lectures do
  attributes :id, :name, :lecture_number
end
