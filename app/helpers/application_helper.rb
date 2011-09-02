module ApplicationHelper

  def body_heading(title)
    content_for :body_heading, title
  end

end