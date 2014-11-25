object @lecture

attributes :id, :lecture_number, :description, :caosule_id, :live

child :documents do
  attributes :id
end

child :videos do
  attributes :id
end

child :comments do
  attributes :id
end
