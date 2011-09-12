require 'spec_helper'

describe HomeController do

  describe 'should not' do
    it 'show the start quiz link when there are no questions to answer' do
      get :index
      response.body.should_not =~ /Start Quiz/
    end
  end

  describe 'should' do
    it 'show the start quiz link when there are questions to answer' do
      Factory(:question)
      get :index
      response.body.should have_selector("a[href='/start']:contains('Start Quiz')")
    end

    it 'set the current question when starting the quiz' do
      question = Factory(:question)

      get :start

      response.should redirect_to(:controller => :questions, :action => :show, :id => question.id)
      session[:current_question].should eql(question)
    end
  end

end