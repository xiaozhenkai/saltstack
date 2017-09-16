nginx-install:
  file.managed:
    - name: /usr/local/src/nginx-{{ pillar['nginx']['version'] }}.tar.gz
    - source: http://nginx.org/download/nginx-{{ pillar['nginx']['version'] }}.tar.gz
    - skip_verify: True
    - user: root
    - group: root
    - mode: 644

