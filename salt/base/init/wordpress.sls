wordpress_source:
  file.managed:
    - name: /tmp/latest.tar.gz
    - source: salt://init/files/latest.tar.gz
    - user: root
    - group: root
    - mode: 644
    
  cmd.run: 
    - name: cd /tmp/ && tar xf latest.tar.gz && cd wordpress && cp -r * /var/www/html
    - unless: test -f /var/www/html/wp-config.php

wordpress_config:
  file.managed:
    - name: /var/www/html/wp-config.php
    - source: salt://init/files/wp-config.php
    - user: apache
    - group: root

