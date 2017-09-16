include:
  - percona.install

percona-service:
  service.running:
    - name: mysql
    - enable: True


