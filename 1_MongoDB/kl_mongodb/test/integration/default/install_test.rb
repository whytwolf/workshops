# Chef InSpec test for recipe kl_mongodb::install

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

# Check that the mongo application exists.
describe file('/usr/bin/mongo') do
  it { should exist }
  it { should be_executable }
end

# Check for the mongod process.
describe processes('mongod') do
  it { should exist }
end

# Is MongoDB listening on the correct port?
describe port(27017) do
  it { should be_listening }
end
