require 'bundler/setup'
require 'sinatra'
require "sinatra/multi_route"
require 'rhymes'
require 'json'
require 'haml'

set :views, File.dirname(__FILE__)

helpers do 
  def word
    (params[:word] || 'rhyme').strip.gsub(/[^a-zA-Z]+/,'+')
  end
end

route :get, :post, '/:word.json' do
  Rhymes.rhyme(word).to_json
end

get '/:word' do
  @rhymes = Rhymes.rhyme(word)
  haml :rhymes
end

route :get, :post, '/' do
  redirect  "/#{word}" 
end
