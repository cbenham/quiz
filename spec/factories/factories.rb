FactoryGirl.define do
  factory :question do
    question 'What shape did people think the Earth used to be?'
    association :answers, :factory => :answer
    after_build { |question| question.choice = question.answers.first unless question.choice }
  end

  factory :answer do
    answer 'The earth was thought to be square.'
  end
end