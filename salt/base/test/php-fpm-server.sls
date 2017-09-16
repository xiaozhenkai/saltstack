php-fpm-service:
   service.running:
    - name: php-fpm
    - enable: True
    - restart: True
    - watch: 
      - file: /data/lemp/php-5.6.31/etc/php.ini
