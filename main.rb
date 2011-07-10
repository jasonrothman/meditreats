require 'rubygems'     
require 'sinatra'         

get '/' do        
  "Hello world!"     
end

get 'add' do
  erb :add
end

