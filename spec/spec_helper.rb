require "volunteer"
require "project"
require "rspec"
require "pry"
require "pg"
require 'dotenv/load'

DB = PG.connect({:dbname => 'volunteer_tracker_test', :password => ENV['PG_PASS']})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM volunteers *;')
    DB.exec('DELETE FROM projects *;')
  end
end
