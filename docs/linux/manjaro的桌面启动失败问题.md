# manjaro的桌面启动问题

由于装机配置使用的13代i5，写下文章时 manjaro 官网中提供的安装镜像存在一定的兼容性问题，会使安装的 manjoro 系统出现桌面启动问题。

这里记录下当时的解决思路。

## 安装时U盘系统中的桌面启动问题

此时可以通过 alt + 2 进入 tty，使用 less 查看位于 `/var/log` 的 `Xorg.0.log` 从而确认各种设备的启动信息。

然而当时的情况是该路径下并未发现 xorg 的 log 文件，也就是说极有可能连 xorg 都没能跑起来，故使用 `sudo pacman-mirrors -c China` 更换国内源之后更新一遍系统，再自行安装 xorg，在 xorg 安装后可以在 `/var/log` 中找到 `Xorg.0.log` 文件，此时便可通过该文件确认设备的启动信息，之后对着 ERR 进行驱动安装和修复即可。

## 安装后的桌面异常问题

安装完 manjaro 并进行升级后遇到了如下桌面异常问题：所有操作的结果都必须在窗口切换时才能回显，在进入 tty 排查后发现应该不是设备驱动等问题，因此考虑换 linux 内核到支持13代cpu的 5.19 版本