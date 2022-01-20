#
# Cookbook:: kl_tomcat
# Spec:: install
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'kl_tomcat::install' do
  context 'When all attributes are default, on CentOS 8' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'centos', '8'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs openjdk 1.7.0' do
      expect(chef_run).to install_package('java-1.7.0-openjdk-devel')
    end

    it 'creates the tomcat group' do
      expect(chef_run).to create_group('tomcat')
    end

    it 'creates the tomcat user' do
      expect(chef_run).to create_user('tomcat')
    end

    it 'downloads the tomcat binaries to /tmp' do
      expect(chef_run).to create_remote_file('/tmp/apache-tomcat-8.5.73.tar.gz')
    end

    it 'extracts the tomcat binaries to /opt/tomcat' do
      expect(chef_run).to extract_archive_file('apache-tomcat-8.5.73.tar.gz').with(
        destination: '/opt/tomcat',
        user: 'tomcat',
        group: 'tomcat',
      )
    end

    it 'downloads the tomcat binaries' do
      expect(chef_run).to create_remote_file('apache-tomcat-8.5.73.tar.gz')
    end

    it 'updates the permissions on directory /opt/tomcat/conf' do
      expect(chef_run).to create_directory('/opt/tomcat/conf').with(
        mode: '0750',
        recursive: true,
      )
    end

    it 'creates the tomcat.service systemd file' do
      expect(chef_run).to create_systemd_unit('/etc/systemd/system/tomcat.service').with(
        content: <<-EOS
          # Systemd unit file for tomcat
          [Unit]
          Description=Apache Tomcat Web Application Container
          After=syslog.target network.target
          
          [Service]
          Type=forking
          
          Environment=JAVA_HOME=/usr/lib/jvm/jre
          Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
          Environment=CATALINA_HOME=/opt/tomcat
          Environment=CATALINA_BASE=/opt/tomcat
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

    it 'enables the tomcat service' do
      expect(chef_run).to enable_service('tomcat')
      expect(chef_run).to start_service('tomcat')
    end
  end
end
