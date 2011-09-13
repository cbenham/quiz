require 'spec_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should have_and_belong_to_many(:numbers) }
  it { should validate_presence_of(:answer) }
  it { should validate_presence_of(:position) }

  context 'with multiple numbers should' do
    before(:each) do
      @answer = Factory(:answer)
      @answer.numbers << @first_number = Factory(:number)
      @answer.numbers << @second_number = Factory(:number, :number => '123456')
    end

    it 'be able to clear them' do
      @answer.clear_contestant_answers

      @answer.numbers.should be_empty

      Number.exists?(@first_number).should be_true
      Number.exists?(@second_number).should be_true
    end
  end
end
