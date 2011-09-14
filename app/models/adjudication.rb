class Adjudication

  FROM = ''
  ACCOUNT_SID = ''
  AUTH_TOKEN = ''

  WINNER_PERSONALISATION = "Congratulations! You are winner %s, present this message to claim your prize."
  LOSER_PERSONALISATION = 'Sorry, you did not win.'
  BODY = "%s You got %s of %s questions correct. Thanks for coming to see my talk!"

  attr_reader :results

  def initialize(results)
    raise 'Score cannot be nil' unless results
    @results = results
  end

  def self.score
    results = Question.all.inject(Hash.new(0)) do |results, question|
      add_results_for_question(results, question)
      results
    end

    Adjudication.new results
  end

  def notify_contestants(number_of_winners)
    notify_winners(number_of_winners)
    notify_losers
  end

  private

  def send_message(number, questions_correct, personalised_message)
    @client ||= Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    @message ||= @client.account.sms.messages

    @question_count ||= Question.count

    text = BODY % [personalised_message, questions_correct, @question_count]
    @message.create(:from => FROM, :to => number, :body => text)
  end

  def notify_first_winner_with_highest_score(number_of_winners)
    number_of_wins = @results.values.max
    if number = extract_highest_scoring_numbers(number_of_wins).sort_by {rand}.first
      send_message(number, number_of_wins, WINNER_PERSONALISATION % number_of_winners)
      @results.delete(number)
    end
  end

  def extract_highest_scoring_numbers(number_of_wins)
    @results.inject([]) do |numbers, pair|
      numbers << pair.first if pair.last == number_of_wins
      numbers
    end
  end

  def notify_winners(number_of_winners)
    (1..number_of_winners).each do |winner_number|
      notify_first_winner_with_highest_score(winner_number)
    end
  end

  def notify_losers
    #Method name meant in jest only
    @results.each { |number, questions_correct| send_message(number, questions_correct, LOSER_PERSONALISATION) }
  end

  def self.add_results_for_question(accumulator, question)
    question.choice.numbers.find_each { |number| accumulator[number.number] += 1 }
  end

end
