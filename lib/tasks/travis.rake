desc 'Run travis CI'
task :travis do
  Rake::Task[':spec'].invoke
end