#
# Cookbook:: kl_tomcat
# Spec:: install
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'kl_tomcat::install' do
  default_attributes['kl_tomcat']['tomcat_version']         = '8.5.73'
  default_attributes['kl_tomcat']['jdk_version']            = '1.7.0'
  default_attributes['kl_tomcat']['tomcat_path']            = '/opt/tomcat'
  default_attributes['kl_tomcat']['user']                   = 'tomcat'
  default_attributes['kl_tomcat']['group']                  = 'tomcat'
  default_attributes['kl_tomcat']['tomcat_archive']         = "apache-tomcat-#{default_attributes['kl_tomcat']['tomcat_version']}.tar.gz"
  default_attributes['kl_tomcat']['jdk_package']            = "java-#{default_attributes['kl_tomcat']['jdk_version']}-openjdk-devel"

  default_attributes['kl_tomcat']['tomcat_archive_source']  = 'https://archive.apache.org/dist/tomcat/'
  default_attributes['kl_tomcat']['tomcat_archive_source']  += "tomcat-#{default_attributes['kl_tomcat']['tomcat_version'][0]}/"
  default_attributes['kl_tomcat']['tomcat_archive_source']  += "v#{default_attributes['kl_tomcat']['tomcat_version']}/bin/"
  default_attributes['kl_tomcat']['tomcat_archive_source']  += "apache-tomcat-#{default_attributes['kl_tomcat']['tomcat_version']}.tar.gz"

  default_attributes['kl_tomcat']['tomcat_service'] = {
                                                        Unit: {
                                                          Description: 'Apache Tomcat Web Application Container',
                                                          After: 'syslog.target network.target',
                                                        },
                                                          Service: {
                                                          Type: 'forking',
                                                          Environment: [
                                                            "'JAVA_HOME=/usr/lib/jvm/jre'",
                                                            "'CATALINA_PID=/opt/tomcat/temp/tomcat.pid'",
                                                            "'CATALINA_HOME=/opt/tomcat'",
                                                            "'CATALINA_BASE=/opt/tomcat'",
                                                            "'CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'",
                                                            "'JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'",
                                                          ],
                                                          ExecStart: '/opt/tomcat/bin/startup.sh',
                                                          ExecStop: '/bin/kill -15 $MAINPID',
                                                          User: 'tomcat',
                                                          Group: 'tomcat',
                                                          UMask: '0007',
                                                          RestartSec: '10',
                                                          Restart: 'always',
                                                        },
                                                        Install: {
                                                          WantedBy: 'multi-user.target',
                                                        },
                                                      }

  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'centos', '7'

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

    it 'extracts the tomcat binaries to /opt/tomcat' do
      expect(chef_run).to nothing_archive_file('apache-tomcat-8.5.73.tar.gz').with(
        destination: '/opt/tomcat',
        owner: 'tomcat',
        group: 'tomcat',
        strip_components: 1
      )
    end

    it 'downloads the tomcat binaries to /tmp' do
      expect(chef_run).to create_remote_file('apache-tomcat-8.5.73.tar.gz').with(
        path: '/tmp/apache-tomcat-8.5.73.tar.gz'
      )
      remote_file = chef_run.remote_file('apache-tomcat-8.5.73.tar.gz')
      expect(remote_file).to notify('archive_file[apache-tomcat-8.5.73.tar.gz]')
    end

    it 'updates the permissions on directory /opt/tomcat/conf' do
      expect(chef_run).to create_directory('/opt/tomcat/conf').with(
        mode: '0750',
        recursive: true
      )
    end

    # Rspec expects the hash keys to be quoted strings instead of symbols.
    it 'creates the tomcat.service systemd file' do
      expect(chef_run).to create_systemd_unit('tomcat.service').with(
        content: {
            'Unit' => {
              'Description' => 'Apache Tomcat Web Application Container',
              'After' => 'syslog.target network.target',
            },
              'Service' => {
              'Type' => 'forking',
              'Environment' => [
                "'JAVA_HOME=/usr/lib/jvm/jre'",
                "'CATALINA_PID=/opt/tomcat/temp/tomcat.pid'",
                "'CATALINA_HOME=/opt/tomcat'",
                "'CATALINA_BASE=/opt/tomcat'",
                "'CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'",
                "'JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'",
              ],
              'ExecStart' => '/opt/tomcat/bin/startup.sh',
              'ExecStop' => '/bin/kill -15 $MAINPID',
              'User' => 'tomcat',
              'Group' => 'tomcat',
              'UMask' => '0007',
              'RestartSec' => '10',
              'Restart' => 'always',
            },
            'Install' => {
              'WantedBy' => 'multi-user.target',
            },
          }
      )
    end

    it 'enables the tomcat service' do
      expect(chef_run).to enable_service('tomcat')
      expect(chef_run).to start_service('tomcat')
    end
  end
end
