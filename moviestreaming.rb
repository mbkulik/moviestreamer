require 'rubygems'
require 'sinatra'
require 'browser'

set :port, 80

configure do
    settings.add_charset << "video/mp4"
    settings.add_charset << "video/webm"
end

get '/' do
	video_type = ""
    	str = ""
	browser = Browser.new(:ua => request.user_agent,
			      :accept_language => "en-us")

	if browser.chrome? or browser.opera? or browser.firefox?
		video_type = ".webm"
	elsif browser.ios? or browser.safari? or browser.ie9?
		video_type = ".mp4"
	else
		"Unsupported Browser"
	end

	Dir.foreach('./public') do |item|
        	next if item.end_with?(video_type) == false
        	stripped_name = String.new(item)
		stripped_name[video_type] = ""
        	str += "<a href=\"" + item + "\">" 
		str +=  stripped_name  + "</a><br />\n"
    	end
    	str
end
