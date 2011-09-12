class Answer < ActiveRecord::Base
  belongs_to :question
  has_and_belongs_to_many :numbers

  validates_presence_of :answer
  validates_presence_of :position
end
