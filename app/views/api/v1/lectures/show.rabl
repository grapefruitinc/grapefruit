object @lecture

attributes :id, :lecture_number, :description, :caosule_id, :live

child :documents do
  attributes :id

  node(:file) { |document| document.file.url }
end

child :videos do
  attributes :id, :title, :description

  node(:youtube_url) { |video| video.youtube_url }
end

child :comments do
  attributes :id, :author_id, :body
end
