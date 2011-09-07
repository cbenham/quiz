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

  def create
    choice = remove_choice_param
    question = Question.new(params[:question])
    question.choice = question.answers[choice]
    question.save!

    redirect_to questions_url
  end

  private

  def remove_choice_param
    question_params = params[:question]
    question_params.delete(:choice).to_i
  end
end
