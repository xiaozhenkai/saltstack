lamp-pkg-installed:
  pkg.installed:
    - names:
      - httpd
      - php
      - php-cli
      - php-common
      - mysql
      - mysql-server
      - php-mysql
      - php-pdo
apache-service:
  file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://init/files/httpd.conf
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: httpd
    - enable: True
mysql.service:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://init/files/my.cnf
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: mysqld
    - enable: True

