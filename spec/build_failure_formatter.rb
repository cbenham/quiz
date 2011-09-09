class BuildFailureFormatter < SimpleCov::Formatter::HTMLFormatter

  def format(result)
    super(result)
    covered_percent = result.covered_percent
    threshold = ENV['PERCENT_EXPECTED_COVERAGE'].to_i || 100
    raise "Poor coverage: #{covered_percent}" if covered_percent < threshold
  end

end