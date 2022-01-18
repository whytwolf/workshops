#
# Cookbook:: kl_mongodb
# Recipe:: install
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# Create the MongoDB repository.
yum_repository 'mongodb' do
  description 'MongoDB Repository'
  baseurl 'http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/'
  gpgcheck false
  enabled true
end

# Install the MongoDB packages.
package 'mongodb-org'

# Enable and start the mongod service.
service 'mongod' do
  action [:enable, :start]
end
