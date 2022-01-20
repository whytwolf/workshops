#
# Cookbook:: kl_tomcat
# Recipe:: install
#
# Copyright:: 2022, The Authors, All Rights Reserved.

tomcat_group = node['kl_tomcat']['group']
tomcat_user = node['kl_tomcat']['user']
tomcat_path = node['kl_tomcat']['tomcat_path']
tomcat_archive = node['kl_tomcat']['tomcat_archive']

# Install the JDK.
package node['kl_tomcat']['jdk_package']

# Create the tomcat group and user.
group tomcat_group

user 'tomcat' do
  gid tomcat_group
  shell '/sbin/nologin'
  home tomcat_path
end

# Extract the binaries to /opt/tomcat.
# Use the 'strip_components' property to extract the archive to /opt/tomcat instead of /opt/tomcat/<archive>.
archive_file tomcat_archive do
  path "/tmp/#{tomcat_archive}"
  destination tomcat_path
  owner tomcat_user
  group tomcat_group
  strip_components 1
  action :nothing
end

# Download the Tomcat binaries from apache.org.
remote_file tomcat_archive do
  source node['kl_tomcat']['tomcat_archive_source']
  path "/tmp/#{tomcat_archive}"
  notifies :extract, "archive_file[#{tomcat_archive}]", :immediately
end

# Ensure that the owner of /opt/tomcat is tomcat:tomcat.
directory tomcat_path do
  owner tomcat_user
  group tomcat_group
end

# Uodate permissions on the /opt/tomcat/conf directory to allow group read and execute.
directory "#{tomcat_path}/conf" do
  mode '0750'
  recursive true
end

# Create the tomcat.service systemd unit file.
systemd_unit 'tomcat.service' do
  content(node['kl_tomcat']['tomcat_service'])
  action :create
end

# Enable and start the tomcat service.
service 'tomcat' do
  action [:enable, :start]
end
