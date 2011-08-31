class BuildFailureFormatter < SimpleCov::Formatter::SimpleFormatter

  def format(result)
    super(result)
    covered_percent = result.covered_percent
    raise "Poor coverage: #{covered_percent}" if covered_percent < 100
  end

end