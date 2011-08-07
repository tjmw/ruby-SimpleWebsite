require 'rubygems'
require 'sinatra/base'
require 'haml'

class SimpleWebsite < Sinatra::Base
    set :root, File.dirname(__FILE__)

    get '/' do
        haml :index
    end

    get '/work' do
        haml :work
    end

    get '/links' do
        haml :links
    end
end
