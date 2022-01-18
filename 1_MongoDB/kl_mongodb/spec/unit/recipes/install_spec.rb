#
# Cookbook:: kl_mongodb
# Spec:: install
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'kl_mongodb::install' do
  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates a yum repository' do
      expect(chef_run).to create_yum_repository('mongodb')
    end

    it 'installs the mongodb packages' do
      expect(chef_run).to install_package('mongodb-org')
    end

    it 'enables and starts the mongodb service' do
      expect(chef_run).to enable_service('mongod')
      expect(chef_run).to start_service('mongod')
    end
  end
end
