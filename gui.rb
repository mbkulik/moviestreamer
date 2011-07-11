require 'rubygems'
require 'hotcocoa'

include HotCocoa

application :name => "Hello World" do |app|
	app.delegate = self
	window(
		:frame => [500, 300, 200, 100],
		:title => "Hello World") do |win|
			win << button(
				:title => "Click Me",
				:on_action => lambda do |sender|
					alert(:message => "Hello")
				end)
		win.will_close { exit }
	end
end
