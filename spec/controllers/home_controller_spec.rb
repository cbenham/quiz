require 'spec_helper'

describe HomeController do

  context 'should not' do
    it 'show the start quiz link when there are no questions to answer' do
      get :index
      response.body.should_not =~ /Start Quiz/
    end
  end

  context 'when starting the quiz should' do

    before(:each) do
      @question = Factory(:question)
    end

    it 'set unset the current question' do
       session[:current_question] = @question.id

      get :start

      response.should redirect_to(:controller => :questions, :action => :show, :id => @question.id)
      session[:current_question].should be_nil
    end

    it 'clear all registered answers' do
      question = Factory(:question)
      number = Factory(:number)

      @question.choice.numbers << number
      @question.save!

      question.choice.numbers << number
      question.save!

      get :start

      response.should redirect_to(:controller => :questions, :action => :show, :id => @question.id)
      @question.numbers.should be_empty
      question.numbers.should be_empty
    end
  end

  context 'should' do
    it 'show the start quiz link when there are questions to answer' do
      Factory(:question)
      get :index
      response.body.should have_selector("a[href='/start']:contains('Start Quiz')")
    end
  end

end