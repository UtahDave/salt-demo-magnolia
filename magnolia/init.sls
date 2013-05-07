magnolia-bundle:
  file.managed:
    - name: /root/magnolia-tomcat-bundle-4.5.8-tomcat-bundle.tar.gz
    - source: salt://magnolia/magnolia-tomcat-bundle-4.5.8-tomcat-bundle.tar.gz

extract-magnolia:
  cmd:
    - wait
    - name: tar xvf /root/magnolia-tomcat-bundle-4.5.8-tomcat-bundle.tar.gz -C /opt
    - watch:
      - file: magnolia-bundle

run-magnolia:
  cmd:
    - run
    - cwd: /opt/magnolia-4.5.8/apache-tomcat-6.0.32/bin
    - name: ./magnolia_control.sh start
    - order: last
