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
      should_receive(:content_for).with(:navigation_links, ['link'])
      nav_links('link')
    end

    it 'should create multiple links when multiple links are supplied' do
      should_receive(:content_for).with(:navigation_links, ['link_one', 'link_two'])
      nav_links('link_one', 'link_two')
    end
  end
end