module ApplicationHelper

  def body_heading(title)
    content_for :body_heading, title
  end

  def nav_links(*link)
    content_for :navigation_links, link
  end

end