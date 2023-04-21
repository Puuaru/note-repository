# java 容器启动报错

`library initialization failed - unable to allocate file descriptor table`

该报错来自 ulimit 参数问题，其可能原因有 linux 的设置问题，
也有可能是 docker 服务的问题

解决：

修改 docker.service 文件，
在 `ExecStart` 的后面添加默认 nofile 参数 `--defualt-ulimit nofile=65536:65536`
