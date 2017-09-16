install-wordpress:
  file.managed:
    - name: /usr/local/src/latest.tar.gz
    - source: https://wordpress.org/latest.tar.gz
    - source_hash: https://wordpress.org/latest.tar.gz.md5
    - user: root
    - group: root
    - mode: 644

