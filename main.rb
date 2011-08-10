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
    # when a user submit the '/new', grab the data from the params
    title = params[:title]
    intro = params[:intro]
    ingredients = params[:ingredients]
    directions = params[:directions]
    img = params[:img]
    category = params[:category]
    strength = params[:strength]

    # creating recipe object
    recipe = Recipe.new(:title=>title, :intro=>intro, :ingredients=>ingredients, :directions=>directions, :img=>img, :category=>category, :strength=>strength)
    recipe.save
    redirect '/'
  end

  # show individual recipe
  get '/recipes/:id' do |id|
    @recipe = Recipe.find(id)
    erb :show
  end

end


# data model
MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com',10023, :pool_size => 5, :timeout => 5)
MongoMapper.database = 'meditreats'
MongoMapper.database.authenticate('Test','Test')

class Recipe
  include MongoMapper::Document
  
  key :title, String
  key :intro, String
  key :instructions, String
  key :directions, String
  key :img, String
  key :category, String
  key :strength, String

  timestamps!
  auto_increment!
end
