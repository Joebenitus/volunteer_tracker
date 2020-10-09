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
  @project = Project.find(params[:id].to_i)
  erb(:project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.update({ title: params[:project_title] })
  redirect to('/projects')
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.delete
  redirect to('/projects')
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:edit_project)
end

post('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i)
  volunteer = Volunteer.new({ name: params[:volunteer], project_id: @project.id, id: nil})
  volunteer.save
  erb(:project)
end

get('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id])
  erb(:volunteer)
end

patch('/projects/:id/volunteers/:volunteer_id') do
  @project = Project.find(params[:id].to_i)
  volunteer = Volunteer.find(params[:volunteer_id])
  volunteer.update({ name: params[:volunteer], project_id: @project.id })
  erb(:project)
end
