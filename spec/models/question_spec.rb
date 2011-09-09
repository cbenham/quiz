require 'spec_helper'

describe Question do
  it { should have_many(:answers) }
  it { should belong_to(:choice) }
  it { should validate_presence_of(:question) }
  it { should validate_presence_of(:choice) }

  describe 'should' do
    before(:each) do
      @question = Factory.build(:question)
    end

    after(:each) do
      Timecop.return
    end

    it 'raise error when created with more than four answers' do
      choice = Factory.build(:answer, :answer => 5, :position => 5)

      @question.choice = choice
      @question.answers << choice

      @question.valid?.should be_false
      @question.errors[:answers].should eql(['Expected exactly 4 answers but found 5'])
    end

    it 'set choice when user choice is set' do
      @question.choice = nil
      @question.user_choice = 0

      @question.valid?.should be_true
      @question.choice.should eql(@question.answers[0])
    end

    it 'set choice to nil when user choice is not made' do
      @question.choice = @question.answers.first
      @question.user_choice = nil

      @question.valid?.should be_false
      @question.errors.messages[:choice].should eql(["can't be blank"])
      @question.choice.should be_nil
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
  end
end
