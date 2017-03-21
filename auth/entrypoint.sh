#!/bin/bash
# NOTE this file is copied from Kinaba official image and adapted

set -e

# Add kibana as command if needed
if [[ "$1" == -* ]]; then
	set -- kibana "$@"
fi

# Run as user "kibana" if the command is "kibana"
if [ "$1" = 'kibana' ]; then
	if [ "$ELASTICSEARCH_URL" ]; then
		sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 '$ELASTICSEARCH_URL'!" /etc/kibana/kibana.yml
	fi

	# BEGIN changes
	if [ "$ES_PASSWORD" ]; then
		sed -ri "s!^(\#\s*)?(elasticsearch\.password:).*!\2 '$ES_PASSWORD'!" /etc/kibana/kibana.yml
	fi
	# END changes

	set -- gosu kibana tini -- "$@"
fi

exec "$@"
