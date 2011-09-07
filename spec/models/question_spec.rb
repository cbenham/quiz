require 'spec_helper'

describe Question do
  it { should have_many(:answers) }
  it { should belong_to(:choice) }
  it { should validate_presence_of(:question) }
  it { should validate_presence_of(:choice) }

  it 'should raise error when created with more than four answers' do
    answers = [choice = Answer.new(:answer => 1, :position => 1)]
    answers << Answer.new(:answer => 2, :position => 2)
    answers << Answer.new(:answer => 3, :position => 3)
    answers << Answer.new(:answer => 4, :position => 4)
    answers << Answer.new(:answer => 5, :position => 5)
    question = Question.new(:question => '1 + 1 = ?', :answers => answers, :choice => choice)

    question.valid?.should be(false)
    question.errors[:answers].should eql(['Expected exactly 4 answers but found 5'])
  end
end
