apache2:
  pkg:
    - installed
    - name: apache2

  service:
    - running
    - reload: True
    - watch:
      - file: /etc/php.ini
      - file: /etc/apache2/sites-enabled/00-default-vhosts.conf
      - file: /etc/apache2/sites-enabled/01-project1-vhosts.conf
      - file: /etc/apache2/sites-enabled/02-project2-vhosts.conf

/etc/php.ini:
  file.managed:
    - source: salt://php/php.ini

/etc/apache2/sites-enabled/00-default-vhosts.conf:
  file.managed:
    - source: salt://apache2/vhosts/default.conf

/etc/apache2/sites-enabled/01-project1-vhosts.conf:
  file.managed:
    - source: salt://apache2/vhosts/project1.conf

/etc/apache2/sites-enabled/02-project2-vhosts.conf:
  file.managed:
    - source: salt://apache2/vhosts/project2.conf