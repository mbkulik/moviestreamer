require 'rubygems'
require 'sinatra'
require 'browser'

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

	Dir.foreach('./public') do |item|
        	next if video_type.include?(File.extname(item)) == false
        	stripped_name = String.new(item)
		stripped_name[File.extname(item)] = ""
        	str += "<a href=\"" + item + "\">" 
		str +=  stripped_name  + "</a><br />\n"
    	end
    	str
end