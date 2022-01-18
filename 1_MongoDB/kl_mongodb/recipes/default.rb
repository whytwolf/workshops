#
# Cookbook:: kl_mongodb
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

%w(selinux install).each do |recipe|
  include_recipe "kl_mongodb::#{recipe}"
end
