include:
  - user.www  
#Nginx
nginx-pkg:
  pkg.installed:
    - names: 
      - pcre-devel
nginx-source-install:
  file.managed:
    - name: /usr/local/src/nginx-1.8.0.tar.gz
    - source: salt://nginx/files/nginx-1.8.0.tar.gz
    - user: root
    - group: root
    - mode: 755

  cmd.run:
    - name: cd /usr/local/src/ && tar xf nginx-1.8.0.tar.gz && cd nginx-1.8.0 && ./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-file-aio --with-http_dav_module && make && make install && chown -R www:www /usr/local/nginx
    - unless: test -d /usr/local/nginx
    - require:
       - user: www-user-group
       - file: nginx-source-install
       - pkg: pkg-init
       - pkg: nginx-pkg
