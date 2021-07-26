
task :default => [:run]

desc "Engage!"
task "run" do
  $LOAD_PATH.unshift(File.dirname(__FILE__), "lib")
  require 'lib/search_zendesk'
  SearchZendesk.start
end