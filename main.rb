require 'bundler/setup'
require 'rubygems'     
require 'sinatra'         
require 'mongo_mapper'
# require 'mustache/sinatra'

class App < Sinatra::Base
  get '/' do        
    @recipes = Recipe.all
    erb :index
  end

  get '/new' do
    erb :new
  end

  post '/new' do
    title = params[:title]
    ingredients = params[:ingredients]
    directions = params[:directions]
    img = params[:img]
    recipe = Recipe.new(:title=>title, :ingredients=>ingredients, :directions=>directions, :img=>img)
    recipe.save
    redirect '/'
  end
end



MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com',10076, :pool_size => 5, :timeout => 5)
MongoMapper.database = 'meditreats-test'
MongoMapper.database.authenticate('meditreats','goodtreats')

class Recipe
  include MongoMapper::Document
  
  key :title, String
  key :instructions, String
  key :directions, String
  key :img, String

  timestamps!
end
