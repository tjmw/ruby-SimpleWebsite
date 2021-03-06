require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'yaml'
require 'net/http'
require 'uri'

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

    get '/showmetheheaders' do
        begin
            if params[:url].nil? || params[:url].empty?
                raise "No url specified"
            end

            url = URI.parse(params[:url])
        rescue
            body "<pre>invalid url</pre>"
        else
            path = url.path
            req = Net::HTTP::Head.new(
                path.nil? || path.empty? ? '/' : path
            )
            res = Net::HTTP.start(url.host, url.port) {|http|
                http.request(req)
            }
            body "<pre>#{res.to_hash.to_yaml}</pre>"
        end
    end
end
