#!/bin/sh
#
#start v2raya
#
export V2RAYA_CONFIG=/home/root/.local/share/v2ray/v2raya-conf
export V2RAYA_V2RAY_BIN=/home/root/.local/share/v2ray/x2ray
export V2RAYA_V2RAY_ASSETSDIR=/home/root/.local/share/v2ray/

cd /home/root/.local/share/v2ray/

/home/root/.local/share/v2ray/v2raya --v2ray-assetsdir /home/root/.local/share/v2ray/ --log-level warn  --log-file /home/root/.local/share/v2ray/logs --log-max-days 2 --config /home/root/.local/share/v2ray/v2raya-conf
