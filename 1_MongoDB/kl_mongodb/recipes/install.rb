#
# Cookbook:: kl_mongodb
# Recipe:: install
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# Create the MongoDB repository.
yum_repository 'mongodb' do
  description 'MongoDB Repository'
  baseurl 'https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.4/x86_64/'
  gpgcheck true
  gpgkey 'https://www.mongodb.org/static/pgp/server-4.4.asc'
  enabled true
end

# Install the MongoDB packages.
package 'mongodb-org'

# Enable and start the mongod service.
service 'mongod' do
  action [:enable, :start]
end
