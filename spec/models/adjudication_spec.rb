require 'spec_helper'

describe Adjudication do

  context 'with no number' do
    it 'should have empty results' do
      Adjudication.score.results.should be_empty
    end
  end

  context 'with numbers' do
    before(:each) do
      @number_one = Factory(:number, :number => '1')
      @number_two = Factory(:number, :number => '2')
      @number_three = Factory(:number, :number => '3')
      @number_four = Factory(:number, :number => '4')
    end

    context 'and no answered questions' do
      it 'should have no correct answers for any question' do
        Adjudication.score.results.should eql({'1' => 0, '2' => 0, '3' => 0, '4' => 0})
      end
    end

    context 'and answered questions' do
      before(:each) do
        first_question = Factory(:question)
        second_question = Factory(:question)
        third_question = Factory(:question)

        first_question.choice.numbers << @number_one << @number_two << @number_three
        first_question.answers.first.numbers << @number_four

        second_question.choice.numbers << @number_one << @number_two
        second_question.answers.first.numbers << @number_three << @number_four

        third_question.choice.numbers << @number_one
        third_question.answers.first.numbers << @number_two << @number_three << @number_four
      end

      it 'should calculate scores' do
        Adjudication.score.results.should eql({'1' => 3, '2' => 2, '3' => 1, '4' => 0})
      end
    end
  end

end