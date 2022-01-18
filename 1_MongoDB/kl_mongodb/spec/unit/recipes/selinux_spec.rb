#
# Cookbook:: kl_mongodb
# Spec:: selinux
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'kl_mongodb::selinux' do
  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the selinux tools' do
      expect(chef_run).to install_selinux_install('selinux_tools')
    end

    it 'creates and installs a selinux module' do
      expect(chef_run).to create_selinux_module('mongodb_cgroup_memory')
    end
  end
end
