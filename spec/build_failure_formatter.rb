class BuildFailureFormatter < SimpleCov::Formatter::SimpleFormatter

  def format(result)
    super(result)
    covered_percent = result.covered_percent
    threshold = ENV['PERCENT_EXPECTED_COVERAGE'].to_i || 100
    raise "Poor coverage: #{covered_percent}" if covered_percent < threshold
  end

end