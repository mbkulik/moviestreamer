require 'rubygems'
require 'sinatra/base'
require 'browser'
require 'haml'
require 'json'

class MovieStreamer < Sinatra::Base

    set :haml, :format => :html5
    set :root, Dir.pwd
    set :public_folder, Proc.new { File.join(root, "public") }
    set :views, Proc.new { File.join(root, "views") }

    configure do
    	settings.add_charset << "video/mp4"
    	settings.add_charset << "video/webm"
    end

    get '/' do
	    video_type = Array.new
    	str = ""
	    browser = Browser.new(:ua => request.user_agent,
			      :accept_language => "en-us")

	    if browser.chrome? or browser.opera? or browser.firefox?
		    video_type.push ".webm"
	    elsif browser.ios? or browser.safari? or browser.ie9? or
	    browser.android?
		    video_type.push ".mp4"
		    video_type.push ".m4v"
	    else
		    "Unsupported Browser"
	    end

        listing = Dir.entries(settings.public_folder)
        listing.sort!()

	    listing.each  do |item|
        	next if video_type.include?(File.extname(item)) == false
        	stripped_name = item.sub(File.extname(item), "")
        	str += "<a href=\"" + item + "\">" + stripped_name  + "</a><br />\n"
    	end
    	@movies = str
	    haml :index
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

    get '/readme' do
	    haml :readme
    end

    get '/browsers' do
	    haml :browsers
    end
end
