require 'fileutils'
require 'churn'

MINIMUM_ALLOWED_CODE_COVERAGE = 100

COVERAGE_DATA_LOCATION = File.join(Rails.root, 'coverage.data')
COVERAGE_REPORT_LOCATION = File.join(Rails.root, 'tmp', 'coverage')

desc 'Run all aspects required to be sure of a working code base'
task :all => ['clean', 'churn', 'reek:production', 'reek:spec', 'enable_simplecov', 'spec']

task(:enable_simplecov) { ENV['COVERAGE'] = 'true' }

task :clean do
  File.delete(COVERAGE_DATA_LOCATION) if File.exists?(COVERAGE_DATA_LOCATION)
  FileUtils.rm_r(COVERAGE_REPORT_LOCATION, :force => true)
end