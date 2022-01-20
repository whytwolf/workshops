#
# Cookbook:: kl_tomcat
# Recipe:: install
#
# Copyright:: 2022, The Authors, All Rights Reserved.

package 'java-1.7.0-openjdk-devel'

group 'tomcat'

user 'tomcat' do
  gid 'tomcat'
  shell '/sbin/nologin'
  home '/opt/tomcat'
end

remote_file '/tmp/apache-tomcat-8.5.73.tar.gz' do
  source 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73.tar.gz'
end

archive_file 'apache-tomcat-8.5.73.tar.gz' do
  path '/tmp/apache-tomcat-8.5.73.tar.gz'
  destination '/opt/tomcat'
  owner 'tomcat'
  group 'tomcat'
end

directory '/opt/tomcat/conf' do
  mode '0750'
  recursive true
end

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

service 'tomcat' do
  action [:enable, :start]
end
