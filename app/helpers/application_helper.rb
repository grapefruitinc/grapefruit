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
    content_for :title, page_title.to_s.html_safe
  end

  # gets an SVG tag
  def svg_tag(path)
    "<object type='image/svg+xml' data='#{path}'></object>".html_safe
  end

  # returns proper copy for multi-use form partials
  def submit_text(object)
    if object.persisted?
      "Update"
    else
      "Create"
    end
  end

  # don't show parentheses if there are zero records
  def parens(number)
    (number == 0) ? "" : "(" + number.to_s + ")"
  end

  # get the full error count of a form object
  def form_error_count(object)
    object.errors.full_unique_messages.count
  end

  # gets the help email
  def help_email
    "<strong>hello</strong> at <strong>grapefruit.link</strong>".html_safe
  end

end
