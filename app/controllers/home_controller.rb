class HomeController < ApplicationController

  def index
    @has_questions = Question.exists?
  end

  def start
    question = Question.first
    session[:current_question] = question
    redirect_to question_path(question)
  end

end