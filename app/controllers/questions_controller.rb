class QuestionsController < ApplicationController

  NUMBER_OF_WINNERS = 1

  respond_to :html

  def new
    @question = Question.new
    4.times { @question.answers.build }
    respond_with @question
  end

  def index
    @questions = Question.all
    respond_with(@questions)
  end

  def answers
    CurrentQuestion.unmark
    @questions = Question.all
    Adjudication.score.notify_contestants(NUMBER_OF_WINNERS)
    respond_with(@questions)
  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      redirect_to questions_url
    else
      render :new, :status => 400
    end
  end

  def show
    @question = Question.find(params[:id])
    CurrentQuestion.mark @question
    respond_with(@question)
  end
end
