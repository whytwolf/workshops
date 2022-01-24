# Chef InSpec test for recipe kl_windows::audit

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# Ensure Allow log on locally is set to Administrators
describe security_policy do
  its('SeInteractiveLogonRight') { should eq '*S-1-5-32-544' }
end

# Ensure only Administrators and Remote Desktop users can use RDP
describe security_policy do
  its('SeRemoteInteractiveLogonRight') { should eq '*S-1-5-32-544,*S-1-5-32-555' }
end
