require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
also_reload('lib/**/*.rb')
require('pg')
require 'dotenv/load'

DB = PG.connect({:dbname => 'volunteer_tracker_test', :password => ENV['PG_PASS']})

get('/') do
  redirect to('/projects')
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

get('/projects/new') do
  erb(:new_project)
end

post('/projects') do
  title = params[:project_title]
  project = Project.new({ title: title, id: nil})
  project.save
  redirect to('/projects')
end

get('/projects/:id') do
  erb(:project)
end
