class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :choice, :class_name => 'Answer', :foreign_key => :choice_id

  accepts_nested_attributes_for :answers

  validates_presence_of :question
  validates_presence_of :choice
  validate :validate_quantity_of_questions

  private

  def validate_quantity_of_questions
    number_of_answers = answers.size
    errors.add :answers, "Expected exactly 4 answers but found #{number_of_answers}" unless number_of_answers == 4
  end
end
