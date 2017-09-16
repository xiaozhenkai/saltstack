include: 
  - nginx.install

nginx-init:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://nginx/files/nginx-init
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add nginx
    - unless: chkconfig --list|grep nginx
    - require:
      - file: nginx-init

/usr/local/nginx/conf/nginx.conf:
  file.managed:
    - source: salt://nginx/files/nginx.conf
    - user: www
    - group: www
    - mode: 644

nginx-service:
  file.directory:
    - name: /usr/local/nginx/conf/vhost
    - require:
      - cmd: nginx-source-install

  service.running:
    - name: nginx
    - enable: True
    - require:
      - cmd: nginx-init
    - watch: 
      - file: /usr/local/nginx/conf/nginx.conf
