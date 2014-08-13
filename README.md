Debian-repository for Docker
============================

A local repository for publishing deb files for use with apt.

This docker box provides an apt repository based on the tool reprepro. 
The repository is served by an nginx server.


Usage
-----

### Running the box

Get the box from docker's automated builds

	docker pull glenux/debian-repository

Run with 22 and 80 ports opened. Share a directory containing you public SSH keys.

	docker run -d -v $(pwd)/keys:/docker/keys -p 49160:22 -p 49161:80 glenux/debian-repository


### Uploading packages

Fill your ``~/.dput.cf`` with the following content :

	[DEFAULT]
	default_host_main = docker

	[docker]
	fqdn = localhost
	method = scp
	login = user
	incoming = /docker/incoming
	ssh_config_options =
        	Port 9022
        	StrictHostKeyChecking no


Then upload the latest package you maintain :

	$ dput ~/src/foobar_0.1.10_amd64.changes
	Trying to upload package to docker
	Uploading to docker (via scp to 172.17.0.152):
	foobar_0.1.10_all.deb              100%   39KB  39.3KB/s   00:00    
	foobar_0.1.10.dsc                  100%  488     0.5KB/s   00:00    
	foobar_0.1.10.tar.gz               100%  826KB 826.0KB/s   00:00    
	foobar_0.1.10_amd64.changes        100% 1488     1.5KB/s   00:00    
	Successfully uploaded packages.


### Accessing the repository

Add the following line to your source list

	deb http://localhost:49161/debian unstable main contrib non-free


Credits
-------

<!-- ![Gnuside](http://www.gnuside.com/wp-content/themes/gnuside-ignition-0.2-1-g0d0a5ed/images/logo-whitebg-128.png) -->

Got questions? Need help? Tweet at [@glenux](http://twitter.com/glenux).

Debian-Repository for Docker is maintained and funded by [Glenux](http://www.glenux.net)


License
-------

Debian-Repository for Docker is Copyright © 2014 Glenux.

It is free software, and may be redistributed under the terms specified in the LICENSE file.

