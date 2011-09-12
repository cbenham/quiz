class TwilioResponsesController < ApplicationController

  def create
    answer = session[:current_question].answers.find_by_answer(params[:Body])
    answer.numbers.build(:number => params[:From])
    answer.save!
  end

end