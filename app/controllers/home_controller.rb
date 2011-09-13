class HomeController < ApplicationController

  def index
    @has_questions = Question.exists?
  end

  def start
    Question.clear_contestant_answers
    redirect_to question_path(session[:current_question] = Question.first)
  end

end