{{ pillar['php56']['prefix'] }}/etc/php-fpm.d:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - mkdirs: True
    - recurse:
      - user
      - group
      - mode
