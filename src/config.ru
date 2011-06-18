require 'MovieStreamer'

log = File.new("mvs.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)

run Sinatra::Application
