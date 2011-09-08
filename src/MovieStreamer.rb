require 'rubygems'
require 'sinatra/base'
require 'browser'
require 'haml'
require 'nokogiri'

class MovieStreamer < Sinatra::Base

    set :haml, :format => :html5
    set :root, Dir.pwd
    set :public, Proc.new { File.join(root, "public") }
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

	    Dir.foreach(settings.public) do |item|
        	next if video_type.include?(File.extname(item)) == false
        	stripped_name = item.sub(File.extname(item), "")
        	str += "<a href=\"" + item + "\">" 
		    str +=  stripped_name  + "</a><br />\n"
    	end
    	@movies = str
	    haml :index
        #nokogiri :index
    end

    get '/movielist' do
	    mp4_videos = Array.new
	    webm_videos = Array.new
	    m4v_videos = Array.new

	    Dir.foreach(settings.public) do |vid|
		    case File.extname(vid)
			    when ".webm" then webm_videos.push vid
			    when ".mp4" then  mp4_videos.push vid
			    when ".m4v" then  m4v_videos.push vid
		    end
	    end

	    builder = Nokogiri::XML::Builder.new do |xml|
		    xml.movies {
			    xml.webm {
				    webm_videos.each do |v|
					    xml.movie {
						    xml.title v
					    }
				    end
			    }
			    xml.mp4 {
				    mp4_videos.each do |v|
					    xml.movie {
						    xml.title v
					    }
				    end
			    }
			    xml.m4v {
				    m4v_videos.each do |v|
					    xml.movie {
						    xml.title = v
					    }
				    end
			    }
		    }
	    end

	    builder.to_xml
    end

    get '/readme' do
	    haml :readme
    end

    get '/browsers' do
	    haml :browsers
    end
end
