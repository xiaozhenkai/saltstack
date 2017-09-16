include:
  - nginx_compile.install

nginx-vhost:
  file.directory:
    - name: {{ pillar['nginx']['prefix'] }}/conf/vhost
    - user: root
    - group: root
    - require:
      - cmd: nginx-install

nginx-conf:
  file.managed:
    - name: {{ pillar['nginx']['prefix'] }}/conf/nginx.conf
    - source: salt://nginx_compile/files/nginx.conf
    - user: root
    - group: root
    - template: jinja

nginx-service:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://nginx_compile/files/nginx-init
    - user: root
    - group: root
    - mode: 755
    - template: jinja
  cmd.run:
    - name: chkconfig --add nginx
    - unless: chkconfig --list|grep nginx
  service.running:
    - name: nginx
    - enable: True
    - require: 
      - file: nginx-service
      - cmd: nginx-service
    - watch:
      - file: {{ pillar['nginx']['prefix'] }}/conf/nginx.conf
