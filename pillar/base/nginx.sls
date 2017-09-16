nginx:
  version: 1.10.2
  prefix: /data/lemp/nginx-1.10.2
  root: /data/www
  configure: --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module
