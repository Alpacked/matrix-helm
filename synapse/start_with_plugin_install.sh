#!/bin/sh

for plugin in $(echo $SYNAPSE_PLUGINS | tr ";" "\n")
do
    pip3 install "$plugin"
done

exec python3 /start.py "$@"
