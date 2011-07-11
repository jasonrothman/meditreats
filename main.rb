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

  get 'add' do
    erb :add
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
