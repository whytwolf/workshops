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

# The tomcat service file should exist.
describe file('/etc/systemd/system/tomcat.service') do
  it { should exist }
  its('content') do
    should eq <<-EOS
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking
Environment='JAVA_HOME=/usr/lib/jvm/jre'
Environment='CATALINA_PID=/opt/tomcat/temp/tomcat.pid'
Environment='CATALINA_HOME=/opt/tomcat'
Environment='CATALINA_BASE=/opt/tomcat'
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID
User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOS
  end
end

# The tomcat service should be running
describe service('tomcat') do
  it { should be_running }
end

# We should be listening on port 8080.
describe port(8080) do
  it { should be_listening }
end

# Verify that Tomcat is running on port 8080.
describe command('curl http://localhost:8080') do
  its('stdout') { should match(/Apache\sTomcat/) }
  its('exit_status') { should eq 0 }
end
