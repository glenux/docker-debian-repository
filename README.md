docker-debian-repository
========================

This docker box provides an apt repository based on the tool reprepro. 
The repository is served by an nginx server.

Status : work in progress / not ready for production yet.

Uploading packages
------------------

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


References
----------

### Tutorials

* https://www.isalo.org/wiki.debian-fr/Reprepro
* http://www.howtoforge.com/setting-up-an-apt-repository-with-reprepro-and-nginx-on-debian-wheezy
* http://doc.ubuntu-fr.org/tutoriel/comment_creer_depot
* http://mirrorer.alioth.debian.org/
* https://wiki.debian.org/SettingUpSignedAptRepositoryWithReprepro
* https://www.isalo.org/wiki.debian-fr/Reprepro
