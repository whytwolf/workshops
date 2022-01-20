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
