#
# Cookbook:: kl_windows
# Recipe:: audit
#
# Copyright:: 2022, The Authors, All Rights Reserved.

windows_user_privilege 'Allow logon locally' do
  privilege 'SeInteractiveLogonRight'
  users ['BUILTIN\Administrators']
  action :set
end

windows_user_privilege 'Remote Interactive Logon' do
  privilege 'SeRemoteInteractiveLogonRight'
  users ['BUILTIN\Administrators', 'BUILTIN\Remote Desktop Users']
  action :set
end

windows_security_policy 'EnableAdminAccount' do
  secvalue '0'
  action :set
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
  values [{
    name: 'DisableCAD',
    type: :dword,
    data: 0,
  }]
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient' do
  values [{
    name: 'Enabled',
    type: :dword,
    data: 1,
  }]
  recursive true
  action :create
end

registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer' do
  values [{
    name: 'Enabled',
    type: :dword,
    data: 0,
  }]
  recursive true
  action :create
end
