

.PHONY: install change start build_release

start:
	sudo ruby -C src -rubygems moviestreaming.rb

change:
	./scripts/chmvdir

install:
	sudo gem install mongrel
	sudo gem install sinatra
	sudo gem install browser
	./scripts/chmvdir

build_release:
