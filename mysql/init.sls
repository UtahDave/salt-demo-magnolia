include:
  - mysql.python-mysqldb

mysql-requirements:
  pkg:
    - installed
    - pkgs:
      - mysql-server
      - mysql-client
    - require_in:
      - service: mysql
      - mysql_user: salt

/etc/mysql/my.cnf:
  file:
    - managed
    - source: salt://mysql/my.cnf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - dbserver: 166.78.146.78
    #- dbserver: {{ salt['network.ip_addrs']('eth0').pop() }}

mysql:
  service.running:
    - watch:
      - file: /etc/mysql/my.cnf


salt-local:
  mysql_user.present:
    - name: salt
    - host: localhost
    - password: saltypassword
    - require:
      - pkg: python-mysqldb

salt-anyhost:
  mysql_user.present:
    - name: salt
    - host: '%'
    - password: saltypassword
    - require:
      - pkg: python-mysqldb

salt-demo-master:
  mysql_user.present:
    - name: salt
    - host: {{ grains['fqdn'] }}
    - password: saltypassword
    - require:
      - pkg: python-mysqldb

salt:
  mysql_database:
    - present
    - require:
      - mysql_user: salt
      - pkg: python-mysqldb
  mysql_grants:
    - present
    - grant: all privileges
    - database: salt.*
    - host: demo-saltmaster
    - user: salt
    - require:
      - mysql_database: salt
      - pkg: python-mysqldb

