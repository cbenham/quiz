require 'spec_helper'

describe TwilioResponsesController do

  context 'with a current question' do

    before(:each) do
      @question = Factory(:question)
      session[:current_question] = @question
    end

    it 'should associate an incoming SMS message as an answer with the current question' do
      assert_difference 'Number.count' do
        post :create, :From => '1234567890', :To => '0987654321', :Body => '1'
      end

      number = Number.first
      number.answers.count.should eql(1)
      number.number.should eql('1234567890')
      number.answers.should eql([@question.answers.first])

      @question.answers.find_by_answer('1').numbers.should eql([number])
    end

    it 'should remove any whitespace in an answer' do
      assert_difference 'Number.count' do
        post :create, :From => '1234567890', :To => '0987654321', :Body => ' 1 '
      end

      number = Number.first
      number.answers.count.should eql(1)
      number.number.should eql('1234567890')
      number.answers.should eql([@question.answers.first])

      @question.answers.find_by_answer('1').numbers.should eql([number])
    end
  end

end