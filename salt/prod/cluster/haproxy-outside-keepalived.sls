include:
  - keepalived.install

keepalived-server:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/files/haproxy-outside-keepalived.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja

    {% if grains['fqdn'] == 'saltstack-node1.example.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: MASTER
    - PRIORITYID: 150

    {% elif grains['fqdn'] == 'saltstack-node2.example.com' %}
    - ROUTEID: haproxy_ha
    - STATEID: BACKUP
    - PRIORITYID: 100
    {% endif %}
  
  service.running:
    - name: keepalived
    - enable: True
    - watch:
      - file: keepalived-server
