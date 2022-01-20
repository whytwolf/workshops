#
# Cookbook:: kl_tomcat
# Recipe:: install
#
# Copyright:: 2022, The Authors, All Rights Reserved.

# Install the JDK.
package 'java-1.7.0-openjdk-devel'

# Create the tomcat group and user.
group 'tomcat'

user 'tomcat' do
  gid 'tomcat'
  shell '/sbin/nologin'
  home '/opt/tomcat'
end

# Download the Tomcat binaries from apache.org.
remote_file '/tmp/apache-tomcat-8.5.73.tar.gz' do
  source 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73.tar.gz'
end

# Extract the binaries to /opt/tomcat.
# Use the 'strip_components' property to extract the archive to /opt/tomcat instead of /opt/tomcat/<archive>.
archive_file 'apache-tomcat-8.5.73.tar.gz' do
  path '/tmp/apache-tomcat-8.5.73.tar.gz'
  destination '/opt/tomcat'
  owner 'tomcat'
  group 'tomcat'
  strip_components 1
end

# Ensure that the owner of /opt/tomcat is tomcat:tomcat.
directory '/opt/tomcat' do
  owner 'tomcat'
  group 'tomcat'
end

# Uodate permissions on the /opt/tomcat/conf directory to allow group read and execute.
directory '/opt/tomcat/conf' do
  mode '0750'
  recursive true
end

# Create the tomcat.service systemd unit file.
systemd_unit 'tomcat.service' do
  content({
      Unit: {
        Description: 'Apache Tomcat Web Application Container',
        After: 'syslog.target network.target'
      },
        Service: {
        Type: 'forking',
        Environment: [
          "'JAVA_HOME=/usr/lib/jvm/jre'",
          "'CATALINA_PID=/opt/tomcat/temp/tomcat.pid'",
          "'CATALINA_HOME=/opt/tomcat'",
          "'CATALINA_BASE=/opt/tomcat'",
          "'CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'",
          "'JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'"
        ],
        ExecStart: '/opt/tomcat/bin/startup.sh',
        ExecStop: '/bin/kill -15 $MAINPID',
        User: 'tomcat',
        Group: 'tomcat',
        UMask: '0007',
        RestartSec: '10',
        Restart: 'always'
      },
      Install: {
        WantedBy: 'multi-user.target'
      }
    }
  )
  action :create
end

# Enable and start the tomcat service.
service 'tomcat' do
  action [:enable, :start]
end
