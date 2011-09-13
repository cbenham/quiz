class TwilioResponsesController < ApplicationController

  respond_to :html

  layout false

  def create
    save_answer if current_question
    respond_with(@response_message)
  end

  private

  def current_question
    return @question if @question
    id = session[:current_question_id]
    @question = Question.find(id) if id
  end

  def save_answer
    log_with_number("Initiating answer save: #{body}")
    @number = Number.find_or_create_by_number(:number => params[:From])
    log_with_number("Loaded number: #{@number.inspect}")
    idempotently_delete_current_response_for_number
    save_number_to_answer
  end

  def idempotently_delete_current_response_for_number
    question = current_question
    if question.numbers.find_by_id(@number)
      log_with_number("Number already answered question, destroying previous answer")
      question.answers.find_each { |answer| answer.numbers.destroy(@number) }
    end
  end

  def save_number_to_answer
    raw_response = body
    if answer = current_question.answers.find_by_answer(clean_answer)
      log_with_number("Saving answer #{raw_response} for number")
      answer.numbers << @number
    else
      log_with_number("Unable to save answer: '#{raw_response}'")
      @response_message = 'Answer not recognized, you may try again'
    end
  end

  def body
    params[:Body]
  end

  def clean_answer
    params[:Body].strip
  end

  def log_with_number(message)
    logger.info("#{params[:From]}: #{message}")
  end

end