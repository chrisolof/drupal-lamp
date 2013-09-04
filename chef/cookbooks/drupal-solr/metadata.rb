name             'drupal-solr'
license          'Apache 2.0'
description      'Adds configured solr instance connected to Drupal'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "curl"
depends "drush"
depends "tomcat"
