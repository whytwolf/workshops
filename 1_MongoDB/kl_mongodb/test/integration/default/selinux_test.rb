# Chef InSpec test for recipe kl_mongodb::selinux

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# Check selinux status. For our purposes a Permissive state is ok.
describe selinux do
  it { should be_installed }
  it { should_not be_disabled }
end

# Verify that the mongodb_cgroup_memory module is installed.
describe selinux.modules.where('mongodb_cgroup_memory') do
  it { should exist }
  it { should be_installed }
  it { should be_enabled }
end
