require 'spec_helper'

describe ApplicationHelper do
  describe 'body title' do
    it 'creates content for the body title' do
      should_receive(:content_for).with(:body_heading, "foo")
      body_heading('foo')
    end
  end

  describe 'navigation header links' do
    it 'should be created for single link when only one link is supplied' do
      should_receive(:content_for).with(:navigation_links, '<a href="/questions">Questions</a>')
      nav_links(link_to('Questions', questions_path))
    end

    it 'should create multiple links when multiple links are supplied' do
      should_receive(:content_for).with(:navigation_links, '<a href="/questions">Questions</a>' +
                                                           '<a href="/questions/new">New Question</a>')
      nav_links(link_to('Questions', questions_path), link_to('New Question', new_question_path))
    end
  end
end