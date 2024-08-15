#!/usr/bin/env bash

flag=/app/.config-flag
SERVER_NAME=${SERVER_NAME:-http://localhost}

if [ ! -f $flag ]; then
	CONFIG_FILE=/app/public/_includes/config.inc.php
	echo "\$dbhostname = '${DOMAINMOD_DATABASE_HOST:-db}';" >> $CONFIG_FILE
	echo "\$dbname = '${DOMAINMOD_DATABASE:-domainmod}';" >> $CONFIG_FILE
	echo "\$dbusername = '${DOMAINMOD_DB_USER:-domainmod}';" >> $CONFIG_FILE
	echo "\$dbpassword = '${DOMAINMOD_DB_PASSWORD:-1f74cc83}';" >> $CONFIG_FILE

 	touch $flag
fi

cron
frankenphp run --config /etc/caddy/Caddyfile --adapter caddyfile