include:
  - user.www

pkg-php71:
  pkg.installed:
  - names:
    - gcc 
    - gcc-c++
    - libxml2
    - libxml2-devel
    - openssl
    - openssl-devel
    - libcurl-devel
    - libjpeg-turbo-devel
    - libpng-devel
    - freetype-devel
    - libmcrypt-devel
    - mhash
    - gd
    - gd-devel
php71-source-install:
  file.managed:
    - name: /usr/local/src/php-{{ pillar['php71']['version'] }}.tar.gz
    - source: http://cn2.php.net/distributions/php-{{ pillar['php71']['version'] }}.tar.gz
    - skip_verify: True
  cmd.run:
    - name: cd /usr/local/src/ && tar xf php-{{ pillar['php71']['version'] }}.tar.gz && cd php-{{ pillar['php71']['version'] }} && ./configure --prefix={{ pillar['php71']['prefix'] }} --with-config-file-path={{ pillar['php71']['prefix'] }}/etc --with-config-file-scan-dir={{ pillar['php71']['prefix'] }}/etc/php.d {{ pillar['php71']['configure'] }} && make && make install
    - require:
      - file: php71-source-install
      - user: www-user-group
      - pkg: pkg-php71
    - unless: test -d {{ pillar['php71']['prefix'] }}

php-ini:
  file.managed:
    - name: {{ pillar['php71']['prefix'] }}/etc/php.ini
    - source: salt://php71/files/php.ini-production

php-fpm:
  file.managed:
    - name: {{ pillar['php71']['prefix'] }}/etc/php-fpm.conf
    - source: salt://php71/files/php-fpm.conf.default
    - template: jinja

www-conf:
  file.managed:
    - name: {{ pillar['php71']['prefix'] }}/etc/php-fpm.d/www.conf
    - source: salt://php71/files/www.conf.default
    - template: jinja

php-fpm-service:
  file.managed:
    - name: /etc/init.d/php-fpm71
    - source: salt://php71/files/init.d.php-fpm
    - mode: 755
    - template: jinja
  cmd.run:
    - name: chkconfig --add php-fpm71
    - unless: chkconfig --list|grep php-fpm71
    - require:
      - file: php-fpm-service

  service.running:
    - name: php-fpm71
    - enable: True
    - require:
      - cmd: php-fpm-service
      - file: php-ini
      - file: php-fpm
      - file: www-conf
