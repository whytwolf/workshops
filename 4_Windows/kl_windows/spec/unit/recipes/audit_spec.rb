#
# Cookbook:: kl_windows
# Spec:: audit
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'kl_windows::audit' do
  context 'When all attributes are default, on Windows Server 2019' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'windows', '2019'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'Ensures log on locally is set to Administrators' do
    
    end

    it 'Ensures log on thorough RDP is set to Administrators, Remote Desktop Users' do
    
    end

    it 'Ensures Administrator account status is disabled' do
    
    end

    it 'Ensures CTRL+ALT+DEL is disabled' do
    
    end

    it 'Ensures NTP client is enabled' do
    
    end

    it 'Ensures NTP server is disabled' do
    
    end
  end
end
