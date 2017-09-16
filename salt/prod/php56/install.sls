include:
  - user.www

pkg-php56:
  pkg.installed:
  - names:
    - gcc 
    - gcc-c++
    - libxml2-devel
    - openssl-devel
    - libcurl-devel
    - libjpeg-turbo-devel
    - libpng-devel
    - libicu-devel
    - openldap-devel
php56-source-install:
  file.managed:
    - name: /usr/local/src/php-{{ pillar['php56']['version'] }}.tar.gz
    - source: http://cn2.php.net/distributions/php-{{ pillar['php56']['version'] }}.tar.gz
    - skip_verify: True
  cmd.run:
    - name: cd /usr/local/src/ && tar xf php-{{ pillar['php56']['version'] }}.tar.gz && cd php-{{ pillar['php56']['version'] }} && ./configure --prefix={{ pillar['php56']['prefix'] }} --with-config-file-path={{ pillar['php56']['prefix'] }}/etc {{ pillar['php56']['configure'] }} && make && make install
    - require:
      - file: php56-source-install
      - user: www-user-group
      - pkg: pkg-php56
    - unless: test -d {{ pillar['php56']['prefix'] }}

php-ini:
  file.managed:
    - name: {{ pillar['php56']['prefix'] }}/etc/php.ini
    - source: salt://php56/files/php.ini-production

php-fpm:
  file.managed:
    - name: {{ pillar['php56']['prefix'] }}/etc/php-fpm.conf
    - source: salt://php56/files/php-fpm.conf.default
    - template: jinja

{{ pillar['php56']['prefix'] }}/etc/php-fpm.d:
  file.directory:
    - user: root

{{ pillar['php56']['prefix'] }}/etc/php-fpm.d/www.conf:
  file.managed:
    - source: salt://php56/files/www.conf.default
    - template: jinja
    - require:
      - file: {{ pillar['php56']['prefix'] }}/etc/php-fpm.d

php-fpm-service:
  file.managed:
    - name: /etc/init.d/php-fpm56
    - source: salt://php56/files/init.d.php-fpm
    - mode: 755
    - template: jinja
  cmd.run:
    - name: chkconfig --add php-fpm56
    - unless: chkconfig --list|grep php-fpm56
    - require:
      - file: php-fpm-service

  service.running:
    - name: php-fpm56
    - enable: True
    - require:
      - cmd: php-fpm-service
      - file: php-ini
      - file: php-fpm
