#!/bin/sh
#
#daemon v2raya
#
export V2RAYA_CONFIG=/home/root/.local/share/v2ray/v2raya-conf
export V2RAYA_V2RAY_BIN=/home/root/.local/share/v2ray/x2ray
export V2RAYA_V2RAY_ASSETSDIR=/home/root/.local/share/v2ray/

/sbin/start-stop-daemon --start --background --exec /home/root/.local/share/v2ray/boot/v2raya.sh
```