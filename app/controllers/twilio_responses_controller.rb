class TwilioResponsesController < ApplicationController

  respond_to :html

  layout false

  def create
    store_answer if session[:current_question]
    respond_with(@response_message)
  end

  private

  def store_answer
    parameters = params
    if answer = session[:current_question].answers.find_by_answer(parameters[:Body].strip)
      answer.numbers.build(:number => parameters[:From])
      answer.save!
    else
      @response_message = 'Answer not recognized, you may try again'
    end
  end

end