# kl_tomcat

# Instructions for running

Download the cookbook from here: https://www.dropbox.com/s/kd5vz1wbdbju5l9/kl_tomcat.tgz?dl=0

Upload the cookbook to a VM either locally or in the cloud.

It is recommended to put the cookbook in a `cookbooks` directory under the user's home directory, but not necessary.

Untar the cookbook with the command `tar -xf kl_tomcat.tar.gz`

If chef is not installed on the VM install it with the command `sudo yum -y install https://packages.chef.io/files/stable/chef/17.9.26/el/7/chef-17.9.26-1.el7.x86_64.rpm`

Change directory into the extracted cookbook directory.

Run `sudo chef-client -z`
*Accept the license if prompted

## Notes
This cookbook was built for Redhat/CentOS variants running version 7 or later.

This cookbook is dependent on chef-client version 17.5 or newer.

## Attributes
The following default attributes are available:
* default['kl_tomcat']['tomcat_version']         = '8.5.73'
* default['kl_tomcat']['jdk_version']            = '1.7.0'
* default['kl_tomcat']['tomcat_path']            = '/opt/tomcat'
* default['kl_tomcat']['user']                   = 'tomcat'
* default['kl_tomcat']['group']                  = 'tomcat'
* default['kl_tomcat']['tomcat_archive']         = "apache-tomcat-#{default['kl_tomcat']['tomcat_version']}.tar.gz"
* default['kl_tomcat']['jdk_package']            = "java-#{default['kl_tomcat']['jdk_version']}-openjdk-devel"

* default['kl_tomcat']['tomcat_archive_source']  = 'https://archive.apache.org/dist/tomcat/'
* default['kl_tomcat']['tomcat_archive_source']  += "tomcat-#{default['kl_tomcat']['tomcat_version'][0]}/"
* default['kl_tomcat']['tomcat_archive_source']  += "v#{default['kl_tomcat']['tomcat_version']}/bin/"
* default['kl_tomcat']['tomcat_archive_source']  += "apache-tomcat-#{default['kl_tomcat']['tomcat_version']}.tar.gz"

* default['kl_tomcat']['tomcat_service'] = {
>                                           'Unit': {
                                             'Description': 'Apache Tomcat Web Application Container',
                                             'After': 'syslog.target network.target',
                                           },
                                           'Service': {
                                             'Type': 'forking',
                                             'Environment': [
                                               "'JAVA_HOME=/usr/lib/jvm/jre'",
                                               "'CATALINA_PID=/opt/tomcat/temp/tomcat.pid'",
                                               "'CATALINA_HOME=/opt/tomcat'",
                                               "'CATALINA_BASE=/opt/tomcat'",
                                               "'CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'",
                                               "'JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'",
                                             ],
                                             'ExecStart': '/opt/tomcat/bin/startup.sh',
                                             'ExecStop': '/bin/kill -15 $MAINPID',
                                             'User': 'tomcat',
                                             'Group': 'tomcat',
                                             'UMask': '0007',
                                             'RestartSec': '10',
                                             'Restart': 'always',
                                           },
                                           'Install': {
                                             'WantedBy': 'multi-user.target',
                                           },
                                         }
