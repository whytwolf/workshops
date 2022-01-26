# Chef InSpec test for recipe kl_windows::audit

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# Ensure Allow log on locally is set to Administrators
describe security_policy do
  its('SeInteractiveLogonRight') { should eq ['S-1-5-32-544'] }
end

# Ensure only Administrators and Remote Desktop users can use RDP
describe security_policy do
  its('SeRemoteInteractiveLogonRight') { should cmp ['S-1-5-32-544', 'S-1-5-32-555'] }
end

# Ensure the local Administrator account is disabled
describe security_policy do
  its('EnableAdminAccount') { should eq 0 }
end

# Ensure Interactive logon: Do not require CTRL+ALT+DEL is Disabled
describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') do
  its('DisableCAD') { should eq 0 }
end

# Ensure Windows NTP Client is Enabled
describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient') do
  its('Enabled') { should eq 1 }
end

# Ensure Windows NTP Server is Disabled
describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer') do
  its('Enabled') { should eq 0 }
end
