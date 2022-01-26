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
      expect(chef_run).to set_windows_user_privilege('Allow logon locally').with(
        'privilege': ['SeInteractiveLogonRight'],
        'users': ['BUILTIN\Administrators']
      )
    end

    it 'Ensures log on thorough RDP is set to Administrators, Remote Desktop Users' do
      expect(chef_run).to set_windows_user_privilege('Remote Interactive Logon').with(
        'privilege': ['SeRemoteInteractiveLogonRight'],
        'users': ['BUILTIN\Administrators', 'BUILTIN\Remote Desktop Users']
      )
    end

    it 'Ensures Administrator account status is disabled' do
      expect(chef_run).to set_windows_security_policy('EnableAdminAccount').with(
        'secvalue': '0'
      )
    end

    it 'Ensures CTRL+ALT+DEL is disabled' do
      expect(chef_run).to create_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System').with(
        values: [{
          'name': 'DisableCAD',
          'type': :dword,
          'data': '5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9',
        }]
      )
    end

    it 'Ensures NTP client is enabled' do
      expect(chef_run).to create_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient').with(
        values: [{
          'name': 'Enabled',
          'type': :dword,
          'data': '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b',
        }],
        recursive: true
      )
    end

    it 'Ensures NTP server is disabled' do
      expect(chef_run).to create_registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer').with(
        values: [{
          'name': 'Enabled',
          'type': :dword,
          'data': '5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9',
        }],
        recursive: true
      )
    end
  end
end
