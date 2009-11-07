require 'rake'
begin
  require 'git'
rescue LoadError
  puts "git gem not installed.  If git functionality is required run 'sudo gem install git'"
end
require 'fileutils'

namespace :muck do
  
  def muck_gems
    ["river", "babelphish", "muck-engine", "muck-solr", "muck-raker", "muck-services"]
  end
  
  desc 'Translate app'
  task :translate => :environment do
    puts 'translating'
    system("babelphish -o -y /Users/jbasdf/projects/ocwfinder/config/locales/en.yml")
  end

end
