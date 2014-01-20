module ApplicationHelper

  # returns the page title string
  def full_title(page_title)
    base_title = "Grapefruit"

    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  # sets the page title (for templates)
  def page_title(page_title)
    content_for :title, page_title.to_s
  end

end
