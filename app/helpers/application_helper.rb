module ApplicationHelper

  def body_heading(title)
    content_for :body_heading, title
  end

  def nav_links(*links)
    content_for :navigation_links, raw(links.join)
  end

end