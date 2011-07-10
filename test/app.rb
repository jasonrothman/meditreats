require 'bundler/setup'
require 'sinatra'
require 'mongo_mapper'
require 'mustache/sinatra'

MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com',10076, :pool_size => 5, :timeout => 5)
MongoMapper.database = 'meditreats-test'
MongoMapper.database.authenticate('meditreats','goodtreats')

class Post
  include MongoMapper::Document

  key :title, String
  key :body, String

  timestamps!
end

class App < Sinatra::Base
  register Mustache::Sinatra
  require 'views/layout'

  set :mustache, { :views => 'views/', :templates => 'templates/' }
  
  get '/' do
    mustache :index
  end
end

