require 'bundler/setup'
require 'rubygems'     
require 'sinatra'         
require 'mongo_mapper'

class App < Sinatra::Base
  #show all recipes (for now...)
  get '/' do        
    # @recipes = Recipe.all
    
    @categories = Category.all
    erb :index
  end

  get '/category/:name' do |name|
    @cat = Category.all(:name=>name)
    erb :category
  end

  get '/new/category' do
    erb :new_category
  end

  # create a new category
  post '/new/category' do
    name = params[:name]
    # creating category object
    category = Category.new(:name=>name)
    category.save
    redirect '/'
  end

  get '/new' do
    @cats = Category.all
    erb :new
  end

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

class Category
  include MongoMapper::Document
  
  key :name, String
end

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

end
