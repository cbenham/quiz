class Adjudication

  attr_reader :results

  def initialize(results)
    @results = results
  end

  def self.score
    Adjudication.new(Question.all.inject(initialize_results) do |results, question|
      add_results_for_question(results, question)
      results
    end)
  end

  def notify_contestants

  end

  private

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