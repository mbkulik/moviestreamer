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
		browser = Browser.new(:ua => request.user_agent,
			:accept_language => "en-us")

		if browser.ios? or browser.safari? or browser.android?
			video_extension = "*.{mp4,m4v}"
		elsif browser.chrome? or browser.opera? or browser.firefox?
			video_extension = "*.webm"
		end

		if !video_extension.nil?
			Dir.chdir(settings.public_folder)
			@movies = Dir.glob(video_extension).sort!
			erb :index
		else
			erb :browser_error
		end
	end
	
	get '/json' do
		Dir.chdir(settings.public_folder)
		files = Dir.glob("*.{mp4,m4v,webm}").sort!
		return files.to_json
	end
end