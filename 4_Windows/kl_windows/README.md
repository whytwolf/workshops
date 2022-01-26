# kl_windows

# Installation Instrustions

Download the cookbook from here: https://www.dropbox.com/s/guxkh0j3ty56q3m/kl_windows.zip?dl=0

Upload the cookbook to a VM either locally or in the cloud.

It is recommended to put the cookbook in a `cookbooks` directory under the user's home directory.

From a command window:
* Extract the cookbook with the command `powershell -nologo -noprofile -command "Expand-Archive -Path C:\<path_to>\kl_windows.zip -Destination C:\<path_to>\cookbooks"`
* If chef is not installed on the VM install it with the command `msiexec /i "https://packages.chef.io/files/stable/chef/17.9.26/windows/2019/chef-client-17.9.26-1-x64.msi"`
* Change directory into the `cookbooks` directory.
* Run `chef-client -z --runlist "recipe[kl_windows]"`
*Accept the license if prompted

## Notes
This cookbook was built for Windows Server 2019 using Windows Server 2019 Core.
