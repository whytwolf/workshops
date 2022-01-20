# Chef InSpec test for recipe kl_tomcat::install

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# The tomcat directory should exist.
describe directory('/opt/tomcat') do
  it { should exist }
  its('owner') { should eq 'tomcat' }
  its('group') { should eq 'tomcat' }
end

# The tomcat conf directory should have proper permissions.
describe directory('/opt/tomcat/conf') do
  it { should exist }
  its('owner') { should eq 'tomcat' }
  its('group') { should eq 'tomcat' }
  its('mode') { should cmp '0750' }
end

# The tomcat service should be running
describe service('tomcat') do
  it { should be_running }
end

# We should be listening on port 8080.
describe port(8080) do
  it { should be_listening }
end
