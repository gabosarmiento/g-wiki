task :rails_best_practices do
  path = File.expand_path("../../../", __FILE__)
  sh "rails_best_practices #{path}"
end

task :brakeman do
  sh "brakeman -q -z"
end

task :check do
  Rake::Task['spec'].invoke
  Rake::Task['brakeman'].invoke
  Rake::Task['rails_best_practices'].invoke
end

task :deploy do
  Rake::Task['check'].invoke
  sh "git push origin heroku"
end