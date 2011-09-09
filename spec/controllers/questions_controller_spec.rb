require 'spec_helper'

describe QuestionsController do

  describe 'should' do
    it 'route to the index action' do
      {:get => '/questions'}.should route_to(:controller => 'questions', :action => 'index')
    end

    it 'show a list of questions that have been entered' do
      answers = %w{a b c d}.collect { |letter| Factory(:answer, :position => letter, :answer => "Answer: #{letter}") }
      Factory(:question, :question => "First letter of the alphabet?", :answers => answers, :user_choice => 0)

      answers = %w{a b c d}.collect { |letter| Factory(:answer, :position => letter, :answer => "Answer: #{letter}") }
      Factory(:question, :question => "Second letter of the alphabet?", :answers => answers, :user_choice => 0)

      get :index

      response.should be_success
      response.body.should =~ /First letter of the alphabet?/m
      response.body.should =~ /Second letter of the alphabet?/m
    end

    it 'show the user a form used to create a question and associated answers' do
      get :new

      response.should be_success
      response.body.should_not =~ /The errors below prevented the form from being saved:/
      response.body.should =~ /New Question/m
      response.body.should =~ /Question:/m
      4.times do |i|
        response.body.should =~ /#{i + 1}:/m
      end
      response.body.should =~ /Create Question/m
    end

    it 'create new question upon form submission' do
      assert_difference('Question.count') { post :create, :question => CreateQuestionParameterMerge.new.parameters }

      response.should be_redirect
      Question.count.should eql(1)
      Question.first.question.should eql('What is 1 + 1?')
      Question.first.choice.should eql(Question.first.answers.first)
    end

    it 'show errors when attempting to create an empty question' do
      assert_no_difference('Question.count') { post :create, :question =>
          CreateQuestionParameterMerge.new.parameters(:question => '') }

      response.response_code.should eql(400)
      response.body.should =~ /Question can't be blank/
    end

    it 'show errors when attempting to create a question without a choice' do
      assert_no_difference('Question.count') { post :create, :question =>
          CreateQuestionParameterMerge.new.parameters(:user_choice => nil) }

      response.response_code.should eql(400)
      response.body.should =~ /Choice can't be blank/
    end

    it 'continues to keep options selected when an error occurs' do
      assert_no_difference('Question.count') { post :create, :question =>
          CreateQuestionParameterMerge.new.parameters(:question => '') }

      response.body.should have_selector("input[value='1'][checked='checked']")
    end

    it 'show the answers to a question and render a show answers link when the current question is the last' do
      question = Factory(:question)

      get :show, :id => question.id

      response.body.should =~ Regexp.new(Regexp.escape(question.question))
      response.body.should have_selector("a[href='/questions/answers']")
    end

    it 'render a link to the next question when there are more questions to answer' do
      first_question = nil
      second_question = nil
      Timecop.freeze(2.hours.ago) { first_question = Factory(:question, :question => 'What is 5 - 1?') }
      Timecop.freeze(1.hour.ago) { second_question = Factory(:question) }

      get :show, :id => first_question.id

      response.body.should have_selector("a[href='/questions/#{second_question.id}']")
    end
  end
end