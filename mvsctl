#!/usr/bin/env bash
#
# Michael B. Kulik
# 5/18/2011
# 
# Control script for movie streaming server
#

SRC=src
PID_FILE=/tmp/MovieStreaming.pid

state=$1

case "$state" in
'start')
	echo "Start server in production mode."
	(cd $SRC; nohup rackup -E production -p 8080 -s mongrel -P $PID_FILE & disown)
	;;
'stop')
	if [ -f "${PID_FILE}" ]; then
		PID=`cat "${PID_FILE}"`
		if [ "${PID}" -gt 1 ]; then
			echo "Stopping server"
			kill -TERM ${PID}
		else
			echo "Bad pid!"
		fi
	else
		echo "No pid file found!"
	fi
	;;
'devel')
	echo "Start server in development mode."
	(cd $SRC; rackup -E development -p 8080 -s mongrel)
	;;
'install')
	echo "Install server dependencies."
	sudo gem install rack
	sudo gem install mongrel
	sudo gem install sinatra
	sudo gem install browser
	./scripts/chmvdir
	;;
'build')
	echo "Build a release package."
	rm -rf build/
	mkdir build
	tar -czvf build/mvs.tar.gz mvsctl docs/ scripts/ src/
	;;
'change')
	echo "Change movie directory location."
	./scripts/chmvdir
	;;
*)
	echo "$0 {start|stop|devel|install|build|change}"
	exit 1
	;;
esac
