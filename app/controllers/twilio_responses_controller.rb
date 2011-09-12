class TwilioResponsesController < ApplicationController

  layout false

  def create
    if current_question = session[:current_question]
      answer = current_question.answers.find_by_answer(params[:Body].strip)
      answer.numbers.build(:number => params[:From])
      answer.save!
    end
  end

end