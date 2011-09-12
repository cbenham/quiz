require 'spec_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should have_and_belong_to_many(:numbers) }
  it { should validate_presence_of(:answer) }
  it { should validate_presence_of(:position) }
end
