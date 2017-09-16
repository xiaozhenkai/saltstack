php56:
  version: 5.6.31
  prefix: /data/lemp/php-5.6.31
  configure: --with-libdir=lib64 --enable-fpm --with-fpm-user=www --with-fpm-group=www --enable-mysqlnd --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --enable-opcache --enable-pcntl --enable-mbstring --enable-soap --enable-zip --enable-calendar --enable-bcmath --enable-exif --enable-ftp --enable-intl --with-openssl --with-zlib --with-curl --with-gd --with-zlib-dir=/usr/lib --with-png-dir=/usr/lib --with-jpeg-dir=/usr/lib --with-gettext --with-mhash --with-ldap


php71:
  version: 7.1.9
  prefix: /data/lemp/php-7.1.9
  configure: --with-mcrypt=/usr/include --enable-mysqlnd --with-mysqli --with-pdo-mysql --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-gd --with-iconv --with-zlib --enable-xml --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-mbstring --enable-ftp --enable-gd-native-ttf --with-openssl --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --enable-session --with-curl --with-jpeg-dir --with-freetype-dir --enable-opcache
