class TwilioResponsesController < ApplicationController

  respond_to :html

  layout false

  def create
    save_answer if current_question
    respond_with(@response_message)
  end

  private

  def current_question
    session[:current_question]
  end

  def save_answer
    @number = Number.find_or_create_by_number(:number => params[:From])
    idempotently_delete_current_response_for_number(current_question)
    save_number_to_answer
  end

  def idempotently_delete_current_response_for_number(current_question)
    current_question.answers.find_each { |answer| answer.numbers.destroy(@number) } if
        current_question.numbers.find_by_id(@number)
  end

  def save_number_to_answer
    if answer = current_question.answers.find_by_answer(clean_answer)
      answer.numbers << @number
    else
      @response_message = 'Answer not recognized, you may try again'
    end
  end

  def clean_answer
    params[:Body].strip
  end

end