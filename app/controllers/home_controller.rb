class HomeController < ApplicationController

  def index
    @question = Question.first
  end

end