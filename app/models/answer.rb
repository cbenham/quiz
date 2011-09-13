class Answer < ActiveRecord::Base
  belongs_to :question
  has_and_belongs_to_many :numbers

  validates_presence_of :answer
  validates_presence_of :position

  def clear_contestant_answers
    numbers.destroy_all
  end
end
