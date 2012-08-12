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
		video_extension = ""
		browser = Browser.new(:ua => request.user_agent,
			      :accept_language => "en-us")

		if browser.chrome? or browser.opera? or browser.firefox?
			video_extension = "*.webm"
		elsif browser.ios? or browser.safari? or browser.ie9? or
		browser.android?
			video_extesion = "*.{mp4,m4v}"
		end

		Dir.chdir(settings.public_folder)
		@movies = Dir.glob(video_extension)
		erb :index
    end
	
	get '/json' do
		Dir.chdir(settings.public_folder)
		files = Dir.glob("*.{mp4,m4v,webm}")
		return files.to_json	
	end
end