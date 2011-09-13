class HomeController < ApplicationController

  def index
    @has_questions = Question.exists?
  end

  def start
    Question.clear_contestant_answers
    CurrentQuestion.unmark
    redirect_to question_path(Question.first)
  end

end