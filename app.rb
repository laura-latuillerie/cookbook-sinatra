require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require_relative "recipe"
require_relative "parsing"


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file = File.join(__dir__, 'recipes.csv')
COOKBOOK = Cookbook.new(csv_file)

get "/" do
  @recipes = COOKBOOK.all
  erb :index
end

get "/new" do
  erb :new
end

post '/recipes' do
  new_recipe = Recipe.new(params[:name], params[:description], params[:preptime], "#{params[:rating]} / 5")
  COOKBOOK.add_recipe(new_recipe)
  redirect '/'
end

get '/recipes/:index/delete' do
  COOKBOOK.remove_recipe(params[:index].to_i)
  redirect '/'
end

get '/layout' do
  erb :index
end

get "/about" do
  erb :about
end