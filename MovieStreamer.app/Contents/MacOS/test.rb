require 'rubygems'
require 'rack'
require 'sinatra/base'

class HelloWorld < Sinatra::Base

    get '/' do
        "Hello World!"
    end

end

Rack::Handler::WEBrick.run( HelloWorld.new, :Port => 8080)

#require './MovieStreamer.rb'

#Rack::Handler::Mongrel.run(MovieStreamer.new, :Port => 9000)
