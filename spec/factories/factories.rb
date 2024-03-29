FactoryGirl.define do
  factory :question do
    question '10 + 3 = ?'
    after_build do |question|
      question.answers = 4.times.collect do |i|
        Factory.build(:answer, :answer => [10, 11, 12, 13][i], :position => i + 1)
      end if question.answers.empty?
      question.correct_choice = 3 unless question.correct_choice
      question.choice = question.answers.last unless question.choice
    end
  end

  factory :answer do
    answer 'The earth was thought to be square.'
    position 1
  end

  factory :number do
    number '1234567890'
  end
end