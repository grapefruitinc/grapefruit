module HomeHelper
  def breadcrumbs(links)
    html = "<nav class='breadcrumbs'>"
    links.each do |l|
      html += l
    end
    html += "</nav>"
    html.html_safe
  end
  def void
    "javascript:void(0)"
  end
end
