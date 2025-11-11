#!/bin/bash

FILE="url.txt"
LAST=""
URL=""
while true; do
    if [[ -f "$FILE" ]]; then
        CURRENT=$(cat "$FILE" | grep -oE 'https://[a-zA-Z0-9.-]+\.pinggy\.link')
        if [[ "$CURRENT" != "$LAST" ]]; then
            echo "URL changed: $CURRENT"
            # Call your API here, for example with curl
            curl -X GET "$URL/set/$CURRENT" 
            LAST="$CURRENT"
        fi
    fi
    sleep 5  # check every 5 seconds
done
