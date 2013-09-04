## Cookbook Name:: drupal_solr
## Recipe:: default
##

solr = FALSE

node[:drupal][:sites].each do |key, data|
  site_name = key
  site = data

  if site[:solr]
    solr = TRUE
  end
end

if solr
  include_recipe "drupal-solr::install_solr"

  node[:drupal][:sites].each do |key, data|
    site_name = key
    site = data

    bash "drupalize-solr-conf-files" do
      cwd node['drupal_solr']['home_dir']
      code <<-EOH
        cp /assets/infb/current/profiles/nmd_infbuyer/modules/contrib/search_api_solr/solr-conf/3.x/* #{site_name}conf/. ;
        chown -R #{node['tomcat']['user']}:#{node['tomcat']['group']} .
      EOH
    end
  end
end
