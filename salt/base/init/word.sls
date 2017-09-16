wordpress_source:
  file.managed:
    - name: /tmp/latest.tar.gz
    - source: salt://init/files/latest.tar.gz
    
  cmd.run: 
    - name: cd /tmp/ && tar xf latest.tar.gz && cd wordpress && cp -r * /var/www/html
    - unless: test -f /var/www/html/wp-config.php

wordpress_config:
  file.managed:
    - name: /var/www/html/wp-config.php
    - source: salt://init/files/wp-config.php

wp_mysql_user:
  cmd.run:
    - name: mysql -uroot -e "create database wordpress;" && mysql -uroot -e "grant all on wordpress.* to 'wordpress'@'127.0.0.1' identified by 'wordpress';" && mysql -uroot -e "flush privileges;"
    - unless: test -d /var/lib/mysql/wordpress
