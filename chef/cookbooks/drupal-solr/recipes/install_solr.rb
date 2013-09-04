## Cookbook Name:: drupal_solr
## Recipe:: install_solr
##

include_recipe "tomcat"
include_recipe "curl"

solr_archive = "apache-solr-" + node['drupal_solr']['version']

node[:drupal][:sites].each do |key, data|
  site_name = key
  site = data
  # solr home directory
  directory "#{node['drupal_solr']['home_dir']}/#{site_name}conf" do
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode 0775
    recursive true
  end

  #solr.war directory
  directory "#{node['drupal_solr']['war_dir']}/#{site_name}war" do
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode 0775
    recursive true
  end

  bash "download-solr-#{node['drupal_solr']['version']}" do
    cwd "#{node['drupal_solr']['war_dir']}/#{site_name}war"
    code <<-EOH
      curl #{node['drupal_solr']['url']} | tar xz
      cp #{solr_archive}/example/webapps/solr.war .
    EOH
    creates node['drupal_solr']['war_dir'] + "/#{site_name}war" + "/solr.war"
    notifies :restart, "service[tomcat]", :delayed
  end

  solr_context_file = node['tomcat']['context_dir'] + "/" +
                      site_name + ".xml"

  template solr_context_file do
    owner node['tomcat']['user']
    group node['tomcat']['group']
    mode 0644
    source "solr_context.xml.erb"
    notifies :restart, "service[tomcat]"
    variables({
      :site_name => site_name
    })
  end
end
