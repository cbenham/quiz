class Number < ActiveRecord::Base
  has_and_belongs_to_many(:answers)

  validates_uniqueness_of(:number)

  scope :send_contestant_results, lambda {}
end