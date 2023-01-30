# 使用 rofi 实现自定义菜单

## rofi

[rofi](https://github.com/davatorium/rofi) 是一款可以用于替代 dmenu 的程序启动器和窗口切换器，
同时其在 dmenu 模式下对脚本的支持也使它成为自定义菜单的良好选择

## 原理

rofi 在 `-modi` 模式下会将脚本中的输出按照分行作为自己的菜单选项，
而在 `-dmenu` 模式下则会将管道输出作为自己的菜单选项，
同时，当脚本后续仍有对 rofi 的调用时，前一次调用中选中的选项都会作为这次调用的入参

### 选项显示

编辑一个脚本 `test.sh` 填入如下内容并为其添加执行权限：

```bash
echo -e "option1\noption2\noption3"

case $* in
  "option1")
    notify-send "select option1"
    ;;
esac
```

之后执行命令 `rofi -show test -modi "test:./test.sh"`，
选中 `option1`，`option1` 便会成为下一个入参被 `case $*` 捕捉到，从而执行 `case` 语句中的内容

### dmenu 模式

dmenu 模式下，rofi 会将管道的输出作为自己的输入，以此进行选项显示：

```bash
selection=($(bluetoothctl devices | awk '{print $2,$3}' | rofi -i -p 'Connect:' -dmenu))
```
