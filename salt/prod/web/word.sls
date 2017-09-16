#wordpress
install-wordpress:
  file.managed:
    - name: /usr/local/src/latest.tar.gz
    - source: https://wordpress.org/latest.tar.gz
    - source_hash: https://wordpress.org/latest.tar.gz.md5
    - user: root
    - group: root
    - mode: 644
install-wordpress-directory:
  file.directory:
    - name: /data/www/wordpress
    - user: www
    - group: www
    - dir_mode: 755
    - makedirs: True
  cmd.run:
    - name: cd /usr/local/src/ && tar xf latest.tar.gz && cd wordpress && cp -r * /data/www/wordpress/
    - require:
      - file: install-wordpress

wp-database-setting:
  cmd.run:
    - name: mysql -uroot -e "create database wordpress;" && mysql -uroot -e "grant all on wordpress.* to 'wordpress'@'127.0.0.1' identified by 'wordpress';" && mysql -uroot -e "flush privileges;"
    - unless: mysql -uroot -e "use wordpress;"

wp-config-php:
  file.managed:
    - name: /data/www/wordpress/wp-config.php
    - source: salt://web/files/wp-config.php
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: install-wordpress-directory

/usr/local/nginx/conf/vhost/wordpress.conf:
  file.managed:
    - source: salt://web/files/wordpress.conf
    - user: root
    - group: root
    - mode: 644

nginx-service-reload:
  service.running:
  - name: nginx
  - reload: True
  - watch: 
    - file: /usr/local/nginx/conf/vhost/wordpress.conf
