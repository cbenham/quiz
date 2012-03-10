answers = [Answer.new(:answer => 2010, :position => 1),
           Answer.new(:answer => 2011, :position => 2),
           Answer.new(:answer => 2012, :position => 3),
           Answer.new(:answer => 2013, :position => 4)]
Question.create!(:question => 'What year is it?', :answers => answers, :correct_choice => 1)