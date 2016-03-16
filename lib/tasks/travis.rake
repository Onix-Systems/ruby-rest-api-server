desc 'Run travis CI'
task :travis do
  Rake::Task['db:migrate'].invoke
  Rake::Task['spec'].invoke
end