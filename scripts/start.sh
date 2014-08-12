#!/bin/sh

# Many thanks to John Fink <john.fink@gmail.com> for the 
# inspiration and to his great work on docker-wordpress' 

# let's create a user to SSH into
SSH_USERPASS=`pwgen -c -n -1 8`
mkdir /home/user
useradd -G sudo -d /home/user user
chown user /home/user
echo "user:$SSH_USERPASS" | chpasswd
echo "ssh user password: $SSH_USERPASS"

CRONFILE=`mktemp`
cat > $CRONFILE <<EOF
* * * * * echo "pif" >> /home/user/pif.log
EOF
crontab -u user $CRONFILE
rm -f $CRONFILE

supervisord -n

