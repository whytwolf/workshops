#
# Cookbook:: kl_mongodb
# Recipe:: install
#
# Copyright:: 2022, The Authors, All Rights Reserved.

yum_repository 'mongodb' do
  description 'MongoDB Repository'
  baseurl http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
  gpgcheck false
  enabled true
end

package 'mongodb-org'

service 'mongod'
  action [:enable, :start]
end
