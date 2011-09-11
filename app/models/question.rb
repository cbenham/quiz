class Question < ActiveRecord::Base
  has_many :answers, :order => 'position ASC'
  belongs_to :choice, :class_name => 'Answer', :foreign_key => :choice_id

  accepts_nested_attributes_for :answers
  attr_accessor :user_choice

  before_validation :copy_user_choice

  validates_presence_of :question
  validates_presence_of :choice
  validate :validate_quantity_of_questions

  delegate :answer, :to => :choice

  default_scope :order => 'created_at ASC'

  def next_question
    Question.first(:conditions => ['created_at > ?', created_at])
  end

  private

  def validate_quantity_of_questions
    number_of_answers = answers.size
    errors.add :answers, "Expected exactly 4 answers but found #{number_of_answers}" unless number_of_answers == 4
  end

  def copy_user_choice
    actual_choice = user_choice
    self.choice = actual_choice ? answers[actual_choice.to_i] : nil
  end
end
