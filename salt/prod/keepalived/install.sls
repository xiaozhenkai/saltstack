keepalived-install:
  file.managed:
    - name: /usr/local/src/keepalived-1.2.17.tar.gz
    - source: salt://keepalived/files/keepalived-1.2.17.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src/ && tar xf keepalived-1.2.17.tar.gz && cd keepalived-1.2.17 && ./configure --prefix=/usr/local/keepalived --disable-fwmark && make && make install
    - unless: test -d /usr/local/keepalived
    - require:
      - file: keepalived-install

/etc/sysconfig/keepalived:
  file.managed:
    - source: salt://keepalived/files/keepalived.sysconfig
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: keepalived-install

/etc/init.d/keepalived:
  file.managed:
    - source: salt://keepalived/files/keepalived.init
    - user: root
    - group: root
    - mode: 755

keepalived-init:
  cmd.run:
    - name: chkconfig --add keepalived
    - unless: chkconfig --list | grep keepalived
    - require:
      - file: /etc/init.d/keepalived

/etc/keepalived:
  file.directory:
    - user: root
    - group: root

