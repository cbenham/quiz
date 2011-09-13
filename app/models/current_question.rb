class CurrentQuestion < ActiveRecord::Base
  belongs_to :question

  def self.mark(question)
    raise 'Cannot mark nil question' unless question
    CurrentQuestion.first.try(:destroy)
    CurrentQuestion.create!(:question => question)
  end

  def self.unmark
    current_question = CurrentQuestion.first
    current_question.destroy.question if current_question
  end

  def self.current
    CurrentQuestion.first.try(:question)
  end
end