require 'spec_helper'

describe Adjudication do

  it 'should raise exception if created with nil score' do
    lambda { Adjudication.new nil }.should raise_exception(RuntimeError, 'Score cannot be nil')
  end

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
        Adjudication.score.results.should be_empty
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

        @adjudication = Adjudication.score
      end

      it 'should calculate scores' do
        @adjudication.results.should eql({'1' => 3, '2' => 2, '3' => 1})
      end
    end
  end

  context 'with score' do
    before(:each) do
      @twilio_mock = mock()
      @twilio_mock.expects(:account).returns(@twilio_mock)
      @twilio_mock.expects(:sms).returns(@twilio_mock)
      @twilio_mock.expects(:messages).returns(@twilio_mock)

      Twilio::REST::Client.expects(:new).with(instance_of(String), instance_of(String)).returns(@twilio_mock)

      @results = {}
      @adjudication = Adjudication.new(@results)
    end

    it 'should not have a winner when the number of allowed winners is zero' do
      Question.expects(:count).returns(1)

      @results['1'] = 1

      @twilio_mock.expects(:create).with(has_entries(:to => '1',
                                  :body => "Sorry, you did not win. You got 1 of 1 questions correct. Thanks for coming to see my talk!"))

      @adjudication.notify_contestants(0)
    end

    it 'should have one winner when there is one allowed winner' do
      Question.expects(:count).returns(1)

      @results['1'] = 1

      @twilio_mock.expects(:create).with(has_entries(:to => '1',
                                  :body => "Congratulations! You are winner 1, present this message to claim your prize. You got 1 of 1 questions correct. Thanks for coming to see my talk!"))

      @adjudication.notify_contestants(1)
    end

    it 'should have the top two winners when two winners are allowed' do
      Question.expects(:count).returns(3)

      @results.merge!('1' => 3, '2' => 2, '3' => 1)

      @twilio_mock.expects(:create).with(has_entries(:to => '1',
                                         :body => "Congratulations! You are winner 1, present this message to claim your prize. You got 3 of 3 questions correct. Thanks for coming to see my talk!"))
      @twilio_mock.expects(:create).with(has_entries(:to => '2',
                                         :body => "Congratulations! You are winner 2, present this message to claim your prize. You got 2 of 3 questions correct. Thanks for coming to see my talk!"))
      @twilio_mock.expects(:create).with(has_entries(:to => '3',
                                  :body => "Sorry, you did not win. You got 1 of 3 questions correct. Thanks for coming to see my talk!"))

      @adjudication.notify_contestants(2)
    end
  end

end