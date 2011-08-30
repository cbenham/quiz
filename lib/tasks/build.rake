require 'fileutils'

MINIMUM_ALLOWED_CODE_COVERAGE = 100

COVERAGE_DATA_LOCATION = File.join(Rails.root, 'coverage.data')
COVERAGE_REPORT_LOCATION = File.join(Rails.root, 'tmp', 'coverage')

desc 'Run all aspects required to be sure of a working code base'
task :all => ['clean', 'reek:production', 'reek:spec', 'spec'] do
  configure_coverage
  generate_coverage_reports
end

task :clean do
  File.delete(COVERAGE_DATA_LOCATION) if File.exists?(COVERAGE_DATA_LOCATION)
  FileUtils.rm_r(COVERAGE_REPORT_LOCATION, :force => true)
end

private

def configure_coverage
  require File.join(File.dirname(__FILE__), 'support', 'build_failure_formatter.rb')
  require 'cover_me'

  CoverMe.config do |c|
    c.formatter = BuildFailureFormatter
    c.html_formatter.output_path = COVERAGE_REPORT_LOCATION
    c.file_pattern = [/(#{CoverMe.config.project.root}\/app\/.+\.rb)/i]
    c.at_exit = Proc.new do
      puts "\nCoverage report can be found in: #{c.html_formatter.output_path}"
      if BuildFailureFormatter.percent_of_code_covered < MINIMUM_ALLOWED_CODE_COVERAGE
        raise "Poor code coverage, expected: #{MINIMUM_ALLOWED_CODE_COVERAGE}% coverage but was: " +
                  "#{BuildFailureFormatter.percent_of_code_covered}% coverage"
      else
        puts 'Nice! Code coverage is looking good!'
      end
    end
  end
end

def generate_coverage_reports
  CoverMe.complete!
end