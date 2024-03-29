class TwilioResponsesController < ApplicationController

  respond_to :html

  layout false

  protect_from_forgery :except => :create

  def create
    save_answer if CurrentQuestion.current
    respond_with(@response_message)
  end

  private

  def save_answer
    @number = Number.find_or_create_by_number(:number => params[:From])
    idempotently_delete_current_response_for_number
    save_number_to_answer
  end

  def idempotently_delete_current_response_for_number
    question = CurrentQuestion.current
    question.answers.find_each { |answer| answer.numbers.destroy(@number) } if
        question.numbers.find_by_id(@number)
  end

  def save_number_to_answer
    if answer = CurrentQuestion.current.answers.find_by_position(clean_answer)
      answer.numbers << @number
    else
      @response_message = 'Answer not recognized, you may try again'
    end
  end

  def clean_answer
    params[:Body].strip
  end

end