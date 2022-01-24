# kl_tomcat

# Instructions for running

Download the cookbook form here: https://www.dropbox.com/s/kd5vz1wbdbju5l9/kl_tomcat.tgz?dl=0

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
