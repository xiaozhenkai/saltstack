/etc/resolv.conf:
  file.managed: 
    - source: salt://init/files/resolv.conf
    - user: root
    - group: root
    - moude: 644

