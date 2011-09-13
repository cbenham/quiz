class Adjudication

  FROM = ''
  ACCOUNT_SID = ''
  AUTH_TOKEN = ''

  attr_reader :results

  def initialize(results)
    raise 'Score cannot be nil' unless results
    @results = results
  end

  def self.score
    results = Question.all.inject(initialize_results) do |results, question|
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

    text = "Thanks for playing! #{personalised_message} You got #{questions_correct} of #{@question_count} questions correct."
    @message.create(:from => FROM, :to => number, :body => text)
  end

  def notify_first_winner_with_highest_score(winner_number)
    @results.each do |number, number_of_wins|
      if number_of_wins == @results.values.max
        send_message(number, number_of_wins,
                     "Congratulations! You are winner #{winner_number}, present this message to claim your prize.")
        @results.delete(number)
        break
      end
    end
  end

  def notify_winners(number_of_winners)
    (1..number_of_winners).each do |winner_number|
      notify_first_winner_with_highest_score(winner_number)
    end
  end

  def notify_losers
    #Method name meant in jest only
    @results.each { |number, questions_correct| send_message(number, questions_correct, 'Sorry, you did not win.') }
  end

  def self.initialize_results
    Number.all.inject({}) do |results, number|
      results[number.number] = 0
      results
    end
  end

  def self.add_results_for_question(accumulator, question)
    question.choice.numbers.find_each { |number| accumulator[number.number] += 1 }
  end

end