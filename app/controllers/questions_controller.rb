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
    create_question
    if @question.save
      redirect_to questions_url
    else
      render :new, :status => 400
    end
  end

  private

  def create_question
    choice = remove_choice_param
    @question = Question.new(params[:question])
    @question.choice = @question.answers[choice]
  end

  def remove_choice_param
    question_params = params[:question]
    question_params.delete(:choice).to_i
  end
end
