require 'cover_me'

class BuildFailureFormatter < CoverMe::HtmlFormatter

  @@percent_of_code_covered

  def format_index(index)
    super(index)
    @@percent_of_code_covered = index.percent_tested
  end

  def self.percent_of_code_covered
    @@percent_of_code_covered
  end

end