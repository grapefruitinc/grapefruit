module AssignmentsHelper

  def due_in_words(assignment)
    if assignment.true_due_time > Time.now
      "Due " + time_ago_in_words(assignment.true_due_time) + " from now"
    else
      "Was due " + time_ago_in_words(assignment.true_due_time) + " ago"
    end
  end

end
