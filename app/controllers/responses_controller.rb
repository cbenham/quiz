class ResponsesController < ApplicationController

  before_filter :downcase_param_keys, :only => [:create]

  def create
    answer = session[:current_question].answers.find_by_answer(@params[:body])
    answer.numbers.build(:number => @params[:from])
    answer.save!
  end

  private

  def downcase_param_keys
    #The Twilio API sends the keys through, with the first letter capitalised
    parameters = params
    parameters.each_key { |key| (@params ||= {})[key.downcase.to_sym] = parameters[key] }
  end

end