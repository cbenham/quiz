require 'spec_helper'

describe QuestionsController do
  describe 'should' do
    it 'route to the index action' do
      {:get => '/questions'}.should route_to(:controller => 'questions', :action => 'index')
    end

    it 'show a list of questions that have been entered' do
      answers = %w{a b c d}.collect { |letter| Factory(:answer, :position => letter, :answer => "Answer: #{letter}") }
      Factory(:question, :question => "First letter of the alphabet?", :answers => answers,
              :choice => answers.first)

      answers = %w{a b c d}.collect { |letter| Factory(:answer, :position => letter, :answer => "Answer: #{letter}") }
      Factory(:question, :question => "Second letter of the alphabet?", :answers => answers,
              :choice => answers[1])

      get :index

      response.should be_success
      response.body.should =~ /First letter of the alphabet?/m
      response.body.should =~ /Second letter of the alphabet?/m
    end

    it 'show the user a form used to create a question and associated answers' do
      get :new

      response.should be_success
      response.body.should =~ /New Question/m
      response.body.should =~ /Question:/m
      4.times do |i|
        response.body.should =~ /#{i + 1}:/m
      end
      response.body.should =~ /Create Question/m
    end
  end
end