class QuestionsController < ApplicationController

  respond_to :html

  before_filter :only => [:index, :answers] do
    @questions = Question.all
    respond_with(@questions)
  end

  def new
    @question = Question.new
    4.times { @question.answers.build }
    respond_with @question
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
    respond_with(@question)
  end
end
