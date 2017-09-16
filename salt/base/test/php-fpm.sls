php56-fpm-service:
  file.managed:
    - name: /etc/init.d/php-fpm56_jinja
    - source: salt://test/init.d.php-fpm.lemp
    - user: root
    - group: root
    - mode: 755
    - template: jinja     
