 >下载源文件 
`wget http://www.haproxy.org/download/1.5/src/haproxy-1.5.19.tar.gz`

> 修改haproxy启动脚本,文件在haproxy/examples/haproxy.init

`sed -i 's/\/usr\/sbin\/'\$BASENAME'/\/usr\/local\/haproxy\/sbin\/'\$BASENAME'/g' haproxy.init`

### [HAProxy从零开始到掌握](http://www.jianshu.com/p/c9f6d55288c0)
