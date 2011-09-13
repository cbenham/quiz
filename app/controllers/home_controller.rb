class HomeController < ApplicationController

  def index
    @has_questions = Question.exists?
  end

  def start
    Question.clear_contestant_answers
    session[:current_question_id] = nil
    redirect_to question_path(Question.first)
  end

end