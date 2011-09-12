require 'reek/rake/task'
require 'fileutils'
require 'churn'
require 'flay_task'
require 'flog'
require 'open3'

ENV['PERCENT_EXPECTED_COVERAGE'] = '100'
CODE_DUPLICATION_TOLERANCE = 0
TOLERATED_FLOG_PAIN_LEVEL = 120

COVERAGE_DATA_LOCATION = File.join(Rails.root, 'coverage.data')
COVERAGE_REPORT_LOCATION = File.join(Rails.root, 'tmp', 'coverage')

desc 'Run all aspects required to be sure of a working code base'
task :all => ['clean', 'flay', 'flog', 'rails_best_practices', 'reek:production', 'reek:spec', 'churn',
              'enable_simplecov', 'spec']

namespace :reek do
  {:production => 'app', :spec => 'spec'}.each do |env, dir|
    Reek::Rake::Task.new(env) do |t|
      t.source_files = "#{dir}/**/*.rb"
      t.config_files = 'config/production.reek'
      t.reek_opts = ['-q']
    end
  end
end

desc 'Analyze for code duplication'
task :flay do
  banner 'Flay: code duplication detector'
  FlayTask.new do |t|
    t.threshold = CODE_DUPLICATION_TOLERANCE
    t.verbose = true
    t.dirs = %w(app)
  end
end

desc 'Analyze for complex code'
task :flog do
  banner 'Flog: code complexity analyser'
  flog = Flog.new
  flog.flog(['app'])

  formatted_total = '%1.1f' % flog.total
  puts "Flog total: #{formatted_total}"
  puts "Flog method average: %1.1f" % flog.average

  if flog.total > TOLERATED_FLOG_PAIN_LEVEL
    flog.output_details $stdout
    raise "Flog total (#{formatted_total}) is too high! Should be below #{TOLERATED_FLOG_PAIN_LEVEL}"
  end
end

task(:enable_simplecov) { ENV['COVERAGE'] = 'true' }

task :rails_best_practices do
  banner 'Rails best practices'
  Open3.popen3('rails_best_practices') do |stdin, stdout, stderr, wait_thr|
    out = stdout.readlines
    raise out.join unless wait_thr.value == 0
  end
end

desc 'Clean up after having run a build'
task :clean do
  File.delete(COVERAGE_DATA_LOCATION) if File.exists?(COVERAGE_DATA_LOCATION)
  FileUtils.rm_r(COVERAGE_REPORT_LOCATION, :force => true)
end

def banner(message)
  puts '*********************************************'
  puts message
  puts message.size.times.collect{'-'}.join
end