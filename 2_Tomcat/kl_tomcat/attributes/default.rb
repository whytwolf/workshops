default['kl_tomcat']['tomcat_version']         = '8.5.73'
default['kl_tomcat']['jdk_version']            = '1.7.0'
default['kl_tomcat']['tomcat_path']            = '/opt/tomcat'
default['kl_tomcat']['user']                   = 'tomcat'
default['kl_tomcat']['group']                  = 'tomcat'
default['kl_tomcat']['tomcat_archive']         = "apache-tomcat-#{default['kl_tomcat']['tomcat_version']}.tar.gz"
default['kl_tomcat']['jdk_package']            = "java-#{default['kl_tomcat']['jdk_version']}-openjdk-devel"

default['kl_tomcat']['tomcat_archive_source']  = 'https://archive.apache.org/dist/tomcat/'
default['kl_tomcat']['tomcat_archive_source']  += "tomcat-#{default['kl_tomcat']['tomcat_version'][0]}/"
default['kl_tomcat']['tomcat_archive_source']  += "v#{default['kl_tomcat']['tomcat_version']}/bin/"
default['kl_tomcat']['tomcat_archive_source']  += "apache-tomcat-#{default['kl_tomcat']['tomcat_version']}.tar.gz"

default['kl_tomcat']['tomcat_service'] = {
                                           'Unit': {
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
