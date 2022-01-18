#
# Cookbook:: kl_mongodb
# Recipe:: selinux
#
# Copyright:: 2022, The Authors, All Rights Reserved.

selinux_install 'selinux_tools'

selinux_module 'mongodb_cgroup_memory' do
  source 'selinux/mongodb_cgroup_memory.te'
  action :create
end
