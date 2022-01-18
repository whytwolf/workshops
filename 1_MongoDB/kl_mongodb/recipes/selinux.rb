#
# Cookbook:: kl_mongodb
# Recipe:: selinux
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# Install the Selinux management tools.
selinux_install 'selinux_tools'

# Compile and install the mongodb_cgroup_memory selinux module.
selinux_module 'mongodb_cgroup_memory' do
  source 'selinux/mongodb_cgroup_memory.te'
  action :create
end
