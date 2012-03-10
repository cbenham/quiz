require 'spec_helper'

describe Question do
  it { should have_many(:answers) }
  it { should belong_to(:choice) }
  it { should have_many(:numbers).through(:answers) }
  it { should validate_presence_of(:question) }
  it { should validate_presence_of(:choice) }

  describe 'should' do
    before(:each) do
      @question = Factory.build(:question)
    end

    it 'raise error when created with more than four answers' do
      choice = Factory.build(:answer, :answer => 5, :position => 5)

      @question.choice = choice
      @question.answers << choice

      @question.valid?.should be_false
      @question.errors[:answers].should eql(['Expected exactly 4 answers but found 5'])
    end

    it 'set choice when correct choice is set' do
      @question.choice = nil
      @question.correct_choice = 0

      @question.valid?.should be_true
      @question.choice.should eql(@question.answers[0])
    end

    it 'should keep previous choice when correct choice is already set and a new choice has not been chosen' do
      @question.correct_choice = nil
      @question.valid?.should be_true
    end

    it 'be able to find the earliest created question' do
      @question.save!
      Timecop.freeze(Date.yesterday)
      expected_question = Factory(:question)
      Timecop.return
      Question.first.should eql(expected_question)
    end

    it 'find next question after the current question' do
      @question.save!
      Timecop.freeze(1.hour.from_now) { Factory(:question) }
      Timecop.freeze(Date.yesterday)
      first_question = Factory(:question)
      Timecop.return

      first_question.next_question.should eql(@question)
    end

    it 'order answers by position' do
      answers = [choice = Factory(:answer, :answer => 4, :position => 4)]
      answers << first_answer = Factory(:answer, :answer => '1', :position => 1)
      answers << third_answer = Factory(:answer, :answer => '3', :position => 3)
      answers << second_answer = Factory(:answer, :answer => '2', :position => 2)

      question = Factory(:question, :question => 'What is 1 + 3?', :answers => answers, :choice => choice)
      question.answers.reload

      question.answers.should eql([first_answer, second_answer, third_answer, choice])
    end

    it 'be able to remove answers' do
      first_number = Factory(:number)
      second_number = Factory(:number, :number => '4444444')

      first_answer = @question.answers.first
      first_answer.numbers << first_number
      @question.choice.numbers << second_number
      @question.save!

      Question.clear_contestant_answers

      first_answer.reload.numbers.should be_empty
      @question.reload.choice.numbers.should be_empty

      Number.exists?(first_number).should be_true
      Number.exists?(second_number).should be_true
    end
  end
end
