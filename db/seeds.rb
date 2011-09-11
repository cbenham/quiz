answers = [actual_answer = Answer.new(:answer => 10, :position => 1)]
answers << Answer.new(:answer => 20, :position => 2)
answers << Answer.new(:answer => 30, :position => 3)
answers << Answer.new(:answer => 40, :position => 4)
Question.create!(:question => 'What is 10 + 10?', :answers => answers, :choice => actual_answer)
