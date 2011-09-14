answers = [Answer.new(:answer => 'February 24, 1993', :position => 1),
           Answer.new(:answer => 'December 21, 1995', :position => 2),
           Answer.new(:answer => 'December 25, 1996', :position => 3),
           Answer.new(:answer => 'January 10, 1999', :position => 4)]
Question.create!(:question => 'When was the first public release of Ruby?', :answers => answers, :user_choice => 1)

answers = [Answer.new(:answer => 'December 13, 2005', :position => 1),
           Answer.new(:answer => 'January 19, 2007', :position => 2),
           Answer.new(:answer => 'December 7, 2007', :position => 3),
           Answer.new(:answer => 'June 1, 2008', :position => 4)]
Question.create!(:question => 'When was Ruby on Rails 2.0 released?', :answers => answers, :user_choice => 2)

answers = [Answer.new(:answer => 'Prints the number 5', :position => 1),
           Answer.new(:answer => 'Prints nil', :position => 2),
           Answer.new(:answer => 'Prints false', :position => 3),
           Answer.new(:answer => 'Raises an exception', :position => 4)]
Question.create!(:question => 'What does the following do: x = 5 if false; p x', :answers => answers, :user_choice => 1)

answers = [Answer.new(:answer => 'Clears the Hash', :position => 1),
           Answer.new(:answer => 'Fetches the most recently added item', :position => 2),
           Answer.new(:answer => 'Duplicates the Hash', :position => 3),
           Answer.new(:answer => 'Raises an exception', :position => 4)]
Question.create!(:question => 'What does this do: {:a => 1, :b => 2}!', :answers => answers, :user_choice => 3)

answers = [Answer.new(:answer => '"Hello World"', :position => 1),
           Answer.new(:answer => '{"Hello" => "World"}', :position => 2),
           Answer.new(:answer => '["Hello World"]', :position => 3),
           Answer.new(:answer => '["Hello", "World"]', :position => 4)]
Question.create!(:question => 'What does this produce: %w[Hello World]', :answers => answers, :user_choice => 3)