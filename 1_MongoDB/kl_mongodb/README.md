# kl_mongodb

## Instructions for running

Download the cookbook from here: https://www.dropbox.com/s/vpca7xmaclqum7g/kl_mongodb.tgz?dl=0

Upload the cookbook to a VM either locally or in the cloud.

It is recommended to put the cookbook in a `cookbooks` directory under the user's home directory, but not necessary.

Untar the cookbook with the command `tar -xf kl_mongodb.tar.gz`

If chef is not installed on the VM install it with the command `sudo yum -y install https://packages.chef.io/files/stable/chef/17.9.26/el/7/chef-17.9.26-1.el7.x86_64.rpm`

Change directory into the extracted cookbook directory.

Run `sudo chef-client -z`


## Notes
This cookbook was built for Redhat/CentOS variants running version 7 or later.

The cookbook has a dependency on the community `selinux` cookbook, and was exported using `chef export` to satisfy the dependencies in a Chef Zero environment.
