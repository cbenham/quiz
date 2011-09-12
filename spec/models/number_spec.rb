require 'spec_helper'

describe Number do
  it { should have_and_belong_to_many(:answers) }

  it 'should validate the uniqueness of a number' do
    Factory(:number)
    should validate_uniqueness_of(:number)
  end
end
