## Cookbook Name:: drupal-solr
## Attribute:: solr

# must be one of the versions available at http://archive.apache.org/dist/lucene/solr/
# must be consistent with node['drupal_solr']['apachesolr_conf_dir']

default['drupal_solr']['drupal_root'] = ''
default['drupal_solr']['drupal_db'] = ''
default['drupal_solr']['drupal_version'] = '7'
default['drupal_solr']['version']   = '3.6.2'
default['drupal_solr']['url']       = "http://archive.apache.org/dist/lucene/solr/" +
                                       node['drupal_solr']['version'] + "/apache-solr-" +
                                       node['drupal_solr']['version']+ ".tgz"

default['drupal_solr']['app_name']  = "solr"
default['drupal_solr']['war_dir']   = "/opt/solr"
default['drupal_solr']['home_dir']  = "/opt/solr/#{node['drupal_solr']['app_name']}"
default['drupal_solr']['make_solr_default_search'] = true

default['drupal_solr']['php_client_url'] =
  "https://solr-php-client.googlecode.com/files/SolrPhpClient.r22.2009-11-09.tgz"

default['drupal_solr']['apachesolr_install_dir'] = "#{node['drupal_solr']['drupal_root']}/sites/all/modules/apachesolr"

case node['drupal_solr']['drupal_version']
when '7'
  case node['drupal_solr']['version'].split(".")[0]
  when '1'
    default['drupal_solr']['conf_source'] =
      node['drupal_solr']['apachesolr_install_dir'] + "/solr-conf/solr-1.4"
  else
    default['drupal_solr']['conf_source'] =
      node['drupal_solr']['apachesolr_install_dir'] +
      "/solr-conf/solr-" + node['drupal_solr']['version'].split(".")[0]+".x"
  end
when '6'
  default['drupal_solr']['apachesolr_conf_dir'] =
  node['drupal_solr']['apachesolr_install_dir']
end

default['drupal_solr']['mysql_root_password'] = 'root'
