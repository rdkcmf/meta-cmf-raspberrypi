#!/bin/sh

# get init process pid
init_id=`ps aux | grep init | tr -s " " | cut -d " " -f2 | head -n 1`

# if init has a pid and it is 1
if [ "$init_id" = "1" ]; then 
	echo "kill init with pid $init_id" > /tmp/kill_init.log
	kill $init_id
fi

exit 0
