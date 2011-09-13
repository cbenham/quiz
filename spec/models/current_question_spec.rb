require 'spec_helper'

describe CurrentQuestion do
  it { should belong_to(:question) }

  context 'without a currently marked question should' do
    it 'retrieve nil for current question' do
      CurrentQuestion.current.should be_nil
      CurrentQuestion.count.should eql(0)
    end

    it 'be able to mark a question that will be considered current' do
      question = Factory(:question)
      CurrentQuestion.mark(question)
      CurrentQuestion.count.should eql(1)
      CurrentQuestion.current.should eql(question)
    end

    it 'not be able to mark nil question' do
      lambda { CurrentQuestion.mark nil }.should raise_error(RuntimeError, 'Cannot mark nil question')
    end

    it 'do nothing when unmarking' do
      CurrentQuestion.unmark.should be_nil
      CurrentQuestion.current.should be_nil
    end
  end

  context 'already with a currently marked question should' do
    before(:each) do
      @question = Factory(:question)
      CurrentQuestion.mark(@question)
    end

    it 'replace already marked question' do
      question = Factory(:question)
      CurrentQuestion.mark(question)
      CurrentQuestion.count.should eql(1)
      CurrentQuestion.current.should eql(question)
    end

    it 'be able to unmark a question so there is no current question' do
      CurrentQuestion.unmark.should eql(@question)
      CurrentQuestion.current.should be_nil
    end
  end
end