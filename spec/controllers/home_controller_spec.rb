require 'spec_helper'

describe HomeController do

  describe 'should' do
    it 'not show the start quiz link when there are no questions to answer' do
      get :index
      response.body.should_not =~ /Start Quiz/
    end

    it 'show the start quiz link when there are questions to answer' do
      expected_question = Factory(:question)
      Factory(:question)

      get :index

      response.body.should =~ /Start Quiz/
      response.body.should have_selector("a[href='/questions/#{expected_question.id}']")
    end
  end

end