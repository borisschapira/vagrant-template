mod_php:
  cmd:
    - run
    - name: 'sudo a2enmod php5'

mod_rewrite:
  cmd:
    - run
    - name: 'sudo a2enmod rewrite'

restart_apache:
  cmd:
   - run
   - name: 'sudo service apache2 restart'