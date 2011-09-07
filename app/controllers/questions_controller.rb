class QuestionsController < ApplicationController

  respond_to :html

  def index
    @questions = Question.all
    respond_with @questions
  end

  def new
    @question = Question.new
    4.times { @question.answers.build }
    respond_with @question
  end

end
