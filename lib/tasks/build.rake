desc 'Run all aspects required to be sure of a working code base'
task :all => ['reek:production', 'reek:spec', 'spec']