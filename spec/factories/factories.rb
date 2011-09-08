FactoryGirl.define do
  factory :question do
    question '1 + 3 + ?'
    after_build do |question|
      question.answers = 4.times.collect do |i |
        Factory.build(:answer, :answer => i + 1, :position => i + 1)
      end if question.answers.empty?
      question.user_choice = 1 unless question.user_choice
      question.choice = question.answers.first unless question.choice
    end
  end

  factory :answer do
    answer 'The earth was thought to be square.'
    position 1
  end
end