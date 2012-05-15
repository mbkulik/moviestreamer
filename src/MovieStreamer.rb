require 'rubygems'
require 'sinatra/base'
require 'browser'
require 'erb'
require 'json'

class MovieStreamer < Sinatra::Base

	set :root, Dir.pwd
	set :public_folder, Proc.new { File.join(root, "public") }
	set :views, Proc.new { File.join(root, "views") }

	configure do
		settings.add_charset << "video/mp4"
		settings.add_charset << "video/webm"
	end

	get '/' do
		video_type = Array.new
		movies = Array.new
		browser = Browser.new(:ua => request.user_agent,
			      :accept_language => "en-us")

		if browser.chrome? or browser.opera? or browser.firefox?
			video_type.push ".webm"
		elsif browser.ios? or browser.safari? or browser.ie9? or
		browser.android?
			video_type.push ".mp4"
			video_type.push ".m4v"
		end

		listing = Dir.entries(settings.public_folder)
		listing.sort!()

		listing.each  do |item|
			if video_type.include?(File.extname(item))
				movies.push item
			end
		end
		
		@movies = movies
		erb :index
    end

	get '/movielist' do
		movies = Array.new
		exts = [ '.mp4', '.webm', '.m4v' ]

		Dir.foreach( settings.public_folder) do |vid|
			extension = File.extname( vid )

			if extension.empty? == false and exts.include?( extension )
				movies.push( vid )
			end
		end

		movies.sort!()

		return JSON movies
	end
end
