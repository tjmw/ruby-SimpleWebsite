require 'rubygems'
require 'sinatra/base'
require 'haml'

class SimpleWebsite < Sinatra::Base
    set :root, File.dirname(__FILE__)
    attr_reader :current

    get '/' do
        @current = 'index'
        haml :index
    end

    get '/work' do
        @current = 'work'
        haml :work
    end

    get '/links' do
        @current = 'links'
        haml :links
    end
end
