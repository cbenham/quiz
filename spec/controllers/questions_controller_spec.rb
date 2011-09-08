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
      params = { :question => 'What is 1 + 1?', :user_choice => 1,
                 :answers_attributes => { 0 => { :position => 0, :answer => 1 },
                                          1 => { :position => 1, :answer => 2 },
                                          2 => { :position => 2, :answer => 3 },
                                          3 => { :position => 3, :answer => 4 }}}

      assert_difference('Question.count') { post :create, :question => params }

      response.should be_redirect
      Question.count.should eql(1)
      Question.first.question.should eql('What is 1 + 1?')
      Question.first.choice.should eql(Question.first.answers.first)
    end

    it 'show errors when attempting to create an empty question' do
      params = { :question => '', :user_choice => 1,
                 :answers_attributes => { 0 => { :position => 0, :answer => 1 },
                                          1 => { :position => 1, :answer => 2 },
                                          2 => { :position => 2, :answer => 3 },
                                          3 => { :position => 3, :answer => 4 }}}

      assert_no_difference('Question.count') { post :create, :question => params }

      response.response_code.should eql(400)
      response.body.should =~ /Question can't be blank/
    end

    it 'show errors when attempting to create a question without a choice' do
      params = { :question => 'What is 1 + 1?',
           :answers_attributes => { 0 => { :position => 0, :answer => 1 },
                                    1 => { :position => 1, :answer => 2 },
                                    2 => { :position => 2, :answer => 3 },
                                    3 => { :position => 3, :answer => 4 }}}

      assert_no_difference('Question.count') { post :create, :question => params }

      response.response_code.should eql(400)
      response.body.should =~ /Choice can't be blank/
    end

    it 'continues to keep options selected when an error occurs' do
      params = { :question => '', :user_choice => 1,
                 :answers_attributes => { 0 => { :position => 0, :answer => 1 },
                                          1 => { :position => 1, :answer => 2 },
                                          2 => { :position => 2, :answer => 3 },
                                          3 => { :position => 3, :answer => 4 }}}

      assert_no_difference('Question.count') { post :create, :question => params }

      response.body.should have_selector("input[value='1'][checked='checked']")
    end
  end
end