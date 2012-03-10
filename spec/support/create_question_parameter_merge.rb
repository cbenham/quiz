class CreateQuestionParameterMerge
  def initialize
    @params = {:question => 'What is 1 + 1?', :correct_choice => 1, :first_answer => 1, :second_answer => 2,
               :third_answer => 3, :fourth_answer => 4}
  end

  def parameters(params = {})
    @params.merge!(params)
    {:question => @params[:question], :correct_choice => @params[:correct_choice],
     :answers_attributes => {0 => {:position => 1, :answer => @params[:first_answer]},
                             1 => {:position => 2, :answer => @params[:second_answer]},
                             2 => {:position => 3, :answer => @params[:third_answer]},
                             3 => {:position => 4, :answer => @params[:fourth_answer]}}}
  end
end
