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
      response.body.should_not =~ /The errors below prevented the form from being saved:/m
      response.body.should have_selector("h1:contains('New Question')")
      response.body.should have_selector("label:contains('Question:')")
      4.times do |i|
        response.body.should have_selector("label:contains('#{i + 1}:')")
        response.body.should have_selector("input[type='hidden'][value='#{i + 1}']")
      end
      response.body.should have_selector("input[value='Create Question']")
    end

    it 'create new question upon form submission' do
      assert_difference('Question.count') { post :create, :question => CreateQuestionParameterMerge.new.parameters }

      response.should be_redirect
      Question.count.should eql(1)
      Question.first.question.should eql('What is 1 + 1?')
      Question.first.choice.should eql(Answer.find_by_answer('2'))
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

    it 'show the answers to a question when quiz is in play' do
      question = Factory(:question)

      get :show, :id => question.id

      (1..4).each { |answer| response.body.should have_selector("li:contains('#{answer}')") }
    end

    it 'set the current question when showing the question' do
      question = Factory(:question)

      get :show, :id => question.id

      session[:current_question_id].should eql(question.id)
    end

    it 'render a link to the answers when the current question is the last' do
      question = Factory(:question)

      get :show, :id => question.id

      response.body.should =~ Regexp.new(Regexp.escape(question.question))
      response.body.should have_selector("a[href='/questions/answers']")
    end

    it 'render a link to the next question when there are more questions to answer' do
      first_question = nil
      second_question = nil
      Timecop.freeze(2.hours.ago) { first_question = Factory(:question) }
      Timecop.freeze(1.hour.ago) { second_question = Factory(:question) }

      get :show, :id => first_question.id

      response.body.should have_selector("a[href='/questions/#{second_question.id}']")
    end

    it 'show the correct answers to all questions when on the answers page' do
      first_question = Factory(:question)
      second_question = Factory(:question, :question => 'What is 5 - 1 = ?')

      get :answers

      response.body.should =~ Regexp.new(Regexp.escape(first_question.question))
      response.body.should =~ Regexp.new(Regexp.escape(second_question.question))
    end

    it 'unset the current question when the quiz has finished' do
      question = Factory(:question)
      session[:current_question_id] = question.id

      get :answers

      session[:current_question_id].should be_nil
    end
  end
end