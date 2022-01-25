# copyright: 2022, Kevin Lewis

title "Windows Server 2019 Security Benchmark"

# Ensure Allow log on locally is set to Administrators
control "local-logon-1.0" do
  impact 1.0
  title "Ensure Allow log on locally is set to Administrators"
  describe security_policy(translate_sid: true) do
    its('SeInteractiveLogonRight') { should eq ['BUILTIN\Administrators'] }
  end
end

# Ensure only Administrators and Remote Desktop users can use RDP
control "remote-logon-1.0" do
  impact 1.0
  title "Ensure only Administrators and Remote Desktop users can use RDP"
  describe security_policy(translate_sid: true) do
    its('SeRemoteInteractiveLogonRight') { should cmp ['BUILTIN\Administrators', 'BUILTIN\Remote Desktop Users'] }
  end
end

# Ensure the local Administrator account is disabled
control "disable-admin-1.0" do
  impact 1.0
  title "Ensure the local Administrator account is disabled"
  describe security_policy do
    its('EnableAdminAccount') { should eq 0 }
  end
end

# Ensure Interactive logon: Do not require CTRL+ALT+DEL is Disabled
control "disable-cad-1.0" do
  impact 1.0
  title "Ensure Interactive logon: Do not require CTRL+ALT+DEL is Disabled"
  describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System') do
    its('DisableCAD') { should eq 0 }
  end
end

# Ensure Windows NTP Client is Enabled
control "enable-ntp_client-1.0" do
  impact 0.7
  title "Ensure Windows NTP Client is Enabled"
  describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpClient') do
    its('Enabled') { should eq 1 }
  end
end

# Ensure Windows NTP Server is Disabled
control "disable-ntp_server-1.0" do
  impact 0.7
  title "Ensure Windows NTP Server is Disabled"
  describe registry_key('HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer') do
    its('Enabled') { should eq 0 }
  end
end
