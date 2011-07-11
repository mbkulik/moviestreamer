#!/usr/bin/env tclsh

proc start {} {
	set pidfile ./src/mvs.pid
	set fexist [file exist $pidfile]

	if { $fexist == 0 } {
		cd ./src
		exec nohup rackup -E production -p 8080 -s mongrel -P mvs.pid &
		cd ../
	}
}

proc stop {} {
	set pidfile ./src/mvs.pid
	set fexist [file exist $pidfile]

	if { $fexist == 1 } {
		set fp [open $pidfile r]
		set id [read $fp]
		close $fp

		if { $id > 1 } {
			exec kill -TERM $id
		}
	}
}

proc devel {} {
	cd ./src
	exec rackup -E development -p 8080 -s mongrel
}

proc install {} {
	exec sudo gem install rack
	exec sudo gem install mongrel
	exec sudo gem install sinatra
	exec sudo gem install browser
	exec sudo gem install haml
	exec sudo gem install nokogiri
}

proc build {} {
	if { [file exist build/ ] } {
		exec rm -r build/
	}

	if { [file exist docs/ ] } {
		exec rm -r docs/
	}

	file mkdir build
	file mkdir docs
	
	exec tar -czf build/mvs.tar.gz mvsctl mvsctl_gui docs/ src/config.ru src/MovieStreamer.rb

	exec haml src/views/browsers.haml docs/Supported_Browsers.html
	exec haml src/views/readme.haml docs/ReadMe.html
}

proc change { location } {
		set filename ./src/public
		set fexist [file exist $filename]

		if { $fexist == 1 } {
			exec rm ./src/public
		}

		exec ln -s $location $filename
}

proc usage {} {
	puts "mvsctl {start|stop|devel|install|build|change \[path\]}"
}

if { $argv0 == "./mvsctl" } {
	if { $argc >= 1 } {
		set command [lindex $argv 0 ]

		switch $command {

			start 	{ puts "Starting server in production mode."
			  	  start
				}
			stop	{ puts "Stopping server."
			  	  stop
				}
			devel	{ puts "Starting server in development mode."
			  	  devel
				}
			install { puts "Installing server dependencies."
			  	  install
				}
			build	{ puts "Building a release package."
			  	  build 
				}
			change	{ if { $argc == 2 } {
			  	  puts "Changing movie location." 
			  	  set location [lindex $argv 1]
			  	  change $location
			  	  } else {
					puts "Please specify the new movie directory."
			  	  }
                       		} 
			default	{ usage }

		}
	} else { usage }
}
