#!/usr/bin/env bash

if [ "$1" == "" ] ; then
	VER="56"
else
	VER="$1"
fi

printf "\nInitializing mysql.sh Version ($VER)...\n\n"

# Install EPEL repo
if [[ ! -e /etc/yum.repos.d/epel.repo ]]; then
    yum -y install http://mirror.umkc.edu/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
		yum update
fi



# Install Percona MySQL Repo
yum install http://repo.percona.com/yum/percona-release-latest.noarch.rpm -y
# Install Percona MySQL Server, server headers, toolkit and Xtrabackup
yum install Percona-Server-server-$VER Percona-Server-devel-$VER percona-toolkit percona-xtrabackup -y

# Install LDAP packages
yum install openldap openldap-servers openldap-clients -y

# Configure PHP to use LDAP
yum install php-ldap -y
sed -i 's,;extension=ldap.so,extension=ldap.so,g' /etc/php.ini

# Install DHCP server
yum install dhcp -y

# Configure DHCP server
cat <<EOF > /etc/dhcp/dhcpd.conf
subnet 192.168.50.0 netmask 255.255.255.0 {
  range 192.168.50.10 192.168.50.100;
  option routers 192.168.50.1;
  option domain-name "example.com";
  option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOF

# Enable and start DHCP server
systemctl enable dhcpd.service
systemctl start dhcpd.service

# Install Asterisk
yum install -y epel-release
yum install -y asterisk

# Set up Asterisk to run at startup
systemctl enable asterisk
systemctl start asterisk

# Install Apache HTTP server
yum install -y httpd
systemctl enable httpd.service
systemctl start httpd.service

echo "You should be able to reach http://localhost:8080 now (unless the port was redirected.)"
echo "A private network is also set up with a DHCP server at 192.168.50.1 providing network settings."
echo "Asterisk is installed and set up to run at startup."
