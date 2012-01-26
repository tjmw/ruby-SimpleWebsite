require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'yaml'

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

    get '/env' do
        filtered_env = request.env.inject({}){|h, (k,v)| h[k] = v if k =~ /^[A-Z_]+$/; h}
        body "<pre>#{filtered_env.to_yaml}</pre>"
    end
end
