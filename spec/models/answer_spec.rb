require 'spec_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should validate_presence_of(:answer) }
  it { should validate_presence_of(:position) }
end
