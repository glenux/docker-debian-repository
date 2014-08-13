docker-debian-repository
========================

This docker box provides an apt repository based on the tool reprepro. 
The repository is be served by an nginx server.

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


Then try to upload your latest package :

	 dput ~/src/_Glenux/foobar_0.1.3_amd64.changes


References
----------

### Tutorials

* https://www.isalo.org/wiki.debian-fr/Reprepro
* http://www.howtoforge.com/setting-up-an-apt-repository-with-reprepro-and-nginx-on-debian-wheezy
* http://doc.ubuntu-fr.org/tutoriel/comment_creer_depot
* http://mirrorer.alioth.debian.org/
* https://wiki.debian.org/SettingUpSignedAptRepositoryWithReprepro
* https://www.isalo.org/wiki.debian-fr/Reprepro
