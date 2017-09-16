pkg-php:
  pkg.installed:
    - names: 
      - gcc
      - gcc-c++
      - openssl-devel
      - swig
      - libjpeg-turbo-devel
      - libpng-devel
      - freetype-devel
      - libxml2-devel
      - zlib-devel
      - libcurl-devel
      - libmcrypt-devel

libiconv-install:
  file.managed:
    - name: /usr/local/src/libiconv-1.14.tar.gz
    - source: salt://php/files/libiconv-1.14.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src/ && tar xf libiconv-1.14.tar.gz && cd libiconv-1.14 && ./configure --prefix=/usr/local/libiconv && make && make install 
    - unless: test -d /usr/local/libiconv

php-source-install:
  file.managed:
    - name: /usr/local/src/php-5.5.12.tar.gz
    - source: http://cn2.php.net/distributions/php-5.5.12.tar.gz
    - source_hash: b6a6e9c72589c265aafb7b3353a34030
    - user: root
    - group: root
    - mode: 644

  cmd.run:
    - name: cd /usr/local/src/ && tar xf php-5.5.12.tar.gz && cd php-5.5.12 && ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv=/usr/local/libiconv --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --disable-fileinfo --enable-maintainer-zts --enable-opcache=no && make && make install
    - require:
      - file: php-source-install
      - user: www-user-group
    - unless: test -d /usr/local/php

pdo-plugin:
  cmd.run:
    - name: cd /usr/local/src/php-5.5.12/ext/pdo_mysql/ && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install
    - unless: test -f /usr/local/php/lib/php/extensions/*/pdo_mysql.so
    - require: 
      - cmd: php-source-install

php-ini:
  file.managed:
    - name: /usr/local/php/etc/php.ini
    - source: salt://php/files/php.ini-production
    - user: root
    - group: root
    - mode: 644

php-fpm:
  file.managed:
    - name: /usr/local/php/etc/php-fpm.conf
    - source: salt://php/files/php-fpm.conf.default
    - user: root
    - group: root
    - mode: 644
   
php-fpm-service:
  file.managed:
    - name: /etc/init.d/php-fpm
    - source: salt://php/files/init.d.php-fpm
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add php-fpm
    - unless: chkconfig --list|grep php-fpm
    - require:
      - file: php-fpm-service

  service.running:
    - name: php-fpm
    - enable: True
    - require:
      - cmd: php-fpm-service
    - watch:
      - file: php-ini
      - file: php-fpm
