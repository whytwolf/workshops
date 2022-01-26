# kl_windows_2019 InSpec Profile

To run this InSpec profile against a remote machine run the command `inspec exec ./controls/security_benchmark.rb --backend winrm --user <username> --password <password> --host <hostname or IP> --port <port>`


The following security tests are run by this profile:

* (L1) Ensure 'Allow log on locally' is set to 'Administrators'
* (L1) Ensure 'Allow log on through Remote Desktop Services' is set to 'Administrators, Remote Desktop Users'
* (L1) Ensure 'Accounts: Administrator account status' is set to 'Disabled'
* (L1) Ensure 'Interactive logon: Do not require CTRL+ALT+DEL' is set to 'Disabled'
* (L2) Ensure 'Enable Windows NTP Client' is set to 'Enabled'
* (L2) Ensure 'Enable Windows NTP Server' is set to 'Disabled'
