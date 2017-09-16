nginx.pkg:
  pkg.installed:
    - names:
      - wget
      - gcc
      - openssl-devel
      - pcre-devel
      - zlib-devel

nginx-install:
  file.managed:
    - name: /usr/local/src/nginx-{{ pillar['nginx']['version'] }}.tar.gz
    - source: http://nginx.org/download/nginx-{{ pillar['nginx']['version'] }}.tar.gz
    - skip_verify: True
    - user: root
    - group: root
    - mode: 644

  cmd.run:
    - name: cd /usr/local/src/ && tar xf nginx-{{ pillar['nginx']['version'] }}.tar.gz && cd nginx-{{ pillar['nginx']['version'] }} && ./configure --prefix={{ pillar['nginx']['prefix'] }} {{ pillar['nginx']['configure'] }} && make && make install
    - unless: test -d {{ pillar['nginx']['prefix'] }}
    - require: 
      - pkg: nginx.pkg
