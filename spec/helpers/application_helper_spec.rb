require 'spec_helper'

describe ApplicationHelper do
  describe 'body title' do
    it 'creates content for the body title' do
      should_receive(:content_for).with(:body_title, "foo")
      body_title('foo')
    end
  end
end