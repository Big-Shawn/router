#  软路由构建

在路由器上搭建转发软件(v2ray,xray)

支持设备：

- 通则 VN007、VN007+

## 通则 VN007、VN007+ ：

* 准备文件下载 (本项目vn007+文件夹下已经整理好)

* 登陆路由

* 软件安装

* 总结

## 准备文件下载

1. 下载[x2ray-core](https://github.com/XTLS/Xray-core/releases/download/v1.8.23/Xray-linux-arm64-v8a.zip);

2. 下载[v2raya](https://github.com/v2rayA/v2rayA/releases/download/v2.2.5.8/v2raya_linux_arm64_2.2.5.8)

(本项目vn007+文件夹下已经整理好可以直接下载)
## 进入路由

1. 登陆超管用户

2. 打开adb端口设置

3. 登陆路由

```bash
adb connect 192.168.0.1;5555 
// 1. 确保电脑和VN700+ 在同一个局域网下
// 2. 电脑已安装adb的相关驱动
adb shell
// 输入登陆账号 superadmin 
// 输入密码
```

## 软件安装

1. 将上述的两个软件解压至 `/home/root/.local/share/v2ray `;

2. 新建文件夹  `/home/root/.local/share/v2ray/boot/`  `/home/root/.local/share/v2ray/v2raya-conf`  `/home/root/.local/share/v2ray/logs`

3. 新建以下两个文件

   启动文件：`/home/root/.local/share/v2ray/boot/v2raya.sh`

```bash
#!/bin/sh
#
#start v2raya
#
export V2RAYA_CONFIG=/home/root/.local/share/v2ray/v2raya-conf
export V2RAYA_V2RAY_BIN=/home/root/.local/share/v2ray/x2ray
export V2RAYA_V2RAY_ASSETSDIR=/home/root/.local/share/v2ray/

cd /home/root/.local/share/v2ray/

/home/root/.local/share/v2ray/v2raya --v2ray-assetsdir /home/root/.local/share/v2ray/ --log-level warn  --log-file /home/root/.local/share/v2ray/logs --log-max-days 2 --config /home/root/.local/share/v2ray/v2raya-conf
```

进程常驻脚本：`/home/root/.local/share/v2ray/boot/daemon.sh`

```bash
#!/bin/sh
#
#daemon v2raya
#
export V2RAYA_CONFIG=/home/root/.local/share/v2ray/v2raya-conf
export V2RAYA_V2RAY_BIN=/home/root/.local/share/v2ray/x2ray
export V2RAYA_V2RAY_ASSETSDIR=/home/root/.local/share/v2ray/

/sbin/start-stop-daemon --start --background --exec /home/root/.local/share/v2ray/boot/v2raya.sh
```

启动代码插入位置：`/etc/tzscript/init_script.sh`

```bash
....
	/etc/tzscript/yaddns_start.sh &
	/usr/bin/fota &
	test -x /usr/bin/tz_upgrade_client && /usr/bin/tz_upgrade_client -i br0 &
    
    print_system_log
	print_commlog_init

    source /home/root/.local/share/v2ray/boot/daemon.sh

	$ECHO_PRO "Exit mifi start" | $TEE_PRO $LOG_FILE
}
....
```

保存后重启路由器

重启后连接热点，进入 `192.168.0.1:2017`  设置界面，设置过程不再赘述。详细步骤可参看[官方文档](https://v2raya.org/docs/prologue/introduction/)。

## 总结

这里遇到比较花时间的问题是：

1. 如何确定使用什么架构版本的软件。

   其实就是使用 `uname -r` 查看一下就可以了，是 `aarch64` 就是arm64版本的，下载对应的二进制就可以。

   因为在路由器上找不到熟悉的软件管理器，感觉可能要编译，其实直接下载对应平台的二进制文件更快更方便。

2. 对于在路由器上下载不成功的文件 可以使用 `python` 快速建立一个小型的服务器来进行中转下载，挺快的。

   在要共享的文件夹下面执行 `  python3 -m http.server 8800  ` ，然后直接通过局域网访问下载。

3. 再就是使用`adb shell `进入路由器里面进行调试，也是花了些时间找地方把启动代码给插到合适的地方。

4. 对于不能修改系统文件的问题使用  ` mount -o remount,rw /` 重新挂载根节点即可。



技术交流群：

![img.png](pics/img.png)

[Telegram-Link](https://t.me/+k6E4F-iUd-Y1OTNl)




