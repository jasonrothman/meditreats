require 'bundler/setup'
require 'rubygems'     
require 'sinatra'         
require 'mongo_mapper'
require 'mongomapper_id2'

class App < Sinatra::Base
  #show all recipes (for now...)
  get '/' do        
    @recipes = Recipe.all
    erb :index
  end

  get '/new' do
    erb :new
  end

  # create a new recipe
  post '/new' do
    title = params[:title]
    ingredients = params[:ingredients]
    directions = params[:directions]
    img = params[:img]
    recipe = Recipe.new(:title=>title, :ingredients=>ingredients, :directions=>directions, :img=>img)
    recipe.save
    redirect '/'
  end

  # show individual recipe
  get '/:id' do |id|
    @recipe = Recipe.find(:id2=>id)
    erb :show
  end

end



MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com',10076, :pool_size => 5, :timeout => 5)
MongoMapper.database = 'meditreats-test'
MongoMapper.database.authenticate('meditreats','goodtreats')

class Recipe
  include MongoMapper::Document
  
  key :title, String
  key :intro, String
  key :instructions, String
  key :directions, String
  key :img, String
  key :category, String

  timestamps!
  auto_increment!
end
