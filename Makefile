

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
