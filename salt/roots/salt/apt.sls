# we need to install dotdeb to be able to have php5.5
#/etc/apt/sources.list.d/dotdeb.list:
#  file:
#    - managed
#    - source: salt://apt/dotdeb.list

#gpg-key:
#  cmd:
#    - run
#    - name: 'wget -O - http://www.dotdeb.org/dotdeb.gpg | apt-key add -'
#    - unless: 'apt-key list | grep dotdeb'

# pinning to trusty
/etc/apt/sources.list.d/trusty.list:
  file:
    - managed
    - source: salt://apt/trusty.list

/etc/apt/preferences.d/trustypref:
  file:
    - managed
    - source: salt://apt/trustypref

apt-update:
  cmd:
    - run
    - name: 'apt-get update'