module CoursesHelper
  def link_to_textbook_problem_sets(course)
    unless course.problem_set_url.blank?
      content_tag(:p, style: "margin-bottom:0px") do
        link_to "Textbook Problem Sets &nbsp; &#10148;".html_safe, course.problem_set_url,
          class: "button small", target: "_blank"
      end
    end
  end
end