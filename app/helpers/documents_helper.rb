module DocumentsHelper
  def document_form(document)
    if document.lecture
      [@course, @capsule, @lecture, @document]
    elsif document.capsule
      [@course, @capsule, @document]
    elsif document.course
      [@course, @document]
    end
  end
end
