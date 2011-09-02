module ApplicationHelper

  def body_title(title)
    content_for :body_title, title
  end

end