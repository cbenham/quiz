class CreateQuestionParameterMerge
  def initialize
    @params = {:question => 'What is 1 + 1?', :user_choice => 1, :first_answer => 1, :second_answer => 2,
               :third_answer => 3, :fourth_answer => 4}
  end

  def parameters(params = {})
    @params.merge!(params)
    {:question => @params[:question], :user_choice => @params[:user_choice],
     :answers_attributes => {0 => {:position => 0, :answer => @params[:first_answer]},
                             1 => {:position => 1, :answer => @params[:second_answer]},
                             2 => {:position => 2, :answer => @params[:third_answer]},
                             3 => {:position => 3, :answer => @params[:fourth_answer]}}}
  end
end
