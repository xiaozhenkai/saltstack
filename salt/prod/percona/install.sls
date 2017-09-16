percona-yum-repository-install:
  pkg.installed:
    - sources: 
      - percona-release: http://www.percona.com/downloads/percona-release/redhat/0.1-4/percona-release-0.1-4.noarch.rpm
    - unless: rpm -qa| grep percona-release-0.1-4

percona-install:
  pkg.installed:
    - names:
      - Percona-Server-server-56
    - unless: rpm -qa| grep Percona-Server-server-56


