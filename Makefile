#
# Michael B. Kulik
# 5/13/2011
#
# Makefile for Movie Streaming Server
#

.PHONY: install change devel build_release production

production:
	sudo ruby -C src -rubygems moviestreaming.rb -p 80 -e production -s mongrel

devel:
	ruby -C src -rubygems moviestreaming.rb -e development -s mongrel

change:
	./scripts/chmvdir

install:
	sudo gem install mongrel
	sudo gem install sinatra
	sudo gem install browser
	./scripts/chmvdir

build_release:
	rm -rf build
	mkdir build
	tar -czvf build/mvs.tar.gz Makefile docs/ scripts/ src/
