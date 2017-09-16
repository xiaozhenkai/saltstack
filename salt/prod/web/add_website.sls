
/data:
  file.directory:
    - user: root
    - group: root
/data/www:
  file.directory:
    - user: www
    - group: www
    - file_mode: 644
    - dir_mode: 755
    - recurse:
      - user
      - group
      - mode
    - require:
      - file: /data
add-website-dir:
  file.directory:
    - name: /data/www/{{ pillar['website']['server_name'] }}
    - user: www
    - group: www
    - mode: 755
    - require:
      - file: /data/www
add-website-nginx-conf:
  file.managed:
    - name: {{ pillar['nginx']['prefix'] }}/conf/vhost/{{ pillar['website']['server_name'] }}.conf
    - source: salt://web/files/www.nginx.conf
    - template: jinja
    - require:
      - file: nginx-vhost
add-website-php-conf:
  file.managed:
    - name: {{ pillar['php56']['prefix'] }}/etc/php-fpm.d/{{ pillar['website']['server_name'] }}.conf
    - source: salt://web/files/www.php.conf
    - template: jinja
    - require:
      - file: {{ pillar['php56']['prefix'] }}/etc/php-fpm.d/www.conf

service-php-fpm-reload:
  service.running:
    - name: php-fpm56
    - require:
      - file: add-website-php-conf
    - watch:
      - file: add-website-php-conf

service-nginx-reload:
  service.running:
    - name: nginx
    - require:
      - file: add-website-php-conf
      - file: add-website-nginx-conf
    - watch:
      - file: add-website-nginx-conf

phpinfo-php:
  file.managed:
    - name: /data/www/{{ pillar['website']['server_name'] }}/index.php
    - source: salt://web/files/phpinfo.php
    - require:
      - file: add-website-dir
