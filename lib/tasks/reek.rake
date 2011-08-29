require 'reek/rake/task'

namespace :reek do
  [:production => 'app', :spec => 'spec'].each do |env, dir|
    Reek::Rake::Task.new(env) do |t|
      t.source_files = "#{dir}/**/*.rb"
      t.config_files = 'config/production.reek'
      t.reek_opts = ['-q']
    end
  end
end