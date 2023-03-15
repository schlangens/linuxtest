# LDAP
Install an LDAP server on virual machine and configure it to be used by the test system.

## Added the Following to the provision.sh file
  # Install LDAP packages
    yum install openldap openldap-servers openldap-clients -y

  # Start LDAP Service
    if pidof systemd > /dev/null ; then
      systemctl enable slapd
      systemctl start slapd
    else
      chkconfig --add slapd
      service slapd start
    fi

  # Configure PHP to use LDAP
    yum install php-ldap -y
    sed -i 's,;extension=ldap.so,extension=ldap.so,g' /etc/php.ini



# Networking
Install a DHCP server within the virtual machine.  Consider changing the provision.sh to automatically install and configure the virtual machine. Configure VirtualBox with a private network so that you can create other virtual machines that use the DHCP server to use https://netboot.xyz/ 

  * This script installs and configures a DHCP server to provide network settings to other virtual machines on a private network with IP address 192.168.50.1. It also installs and configures netboot.xyz for network booting.

  ## Added the Following to the provision.sh file

  # Install DHCP Server
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
    if pidof systemd > /dev/null ; then
      systemctl enable dhcpd.service
      systemctl start dhcpd.service
    else
      chkconfig --add dhcpd
      service dhcpd start
    fi

  # Configure private network
    config.vm.network "private_network", ip: "192.168.50.1"

  # Install netboot.xyz
    yum install wget -y
    cd /var/www/html/
    wget https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe


# Redmine
Install Redmine on the virtual machine and configure it to be used by the test system.  Install a Redmine within the virtual machine.  Also Set up the ElasticSearch plugin as a search engine plugin. Consider changing the provision.sh to automatically install and configure the virtual machine.

  ## Added the Following to the provision.sh file

  # Install Redmine and Elasticsearch plugin
    yum install epel-release -y
    yum install redmine redmine-mysql elasticsearch -y

# Configure Elasticsearch plugin
    cd /usr/share/redmine
    bundle install --without development test
    bundle exec rake redmine:plugins:migrate RAILS_ENV=production

# Start Elasticsearch service
    if pidof systemd > /dev/null ; then
      systemctl enable elasticsearch.service
      systemctl start elasticsearch.service
    else
      chkconfig --add elasticsearch
      service elasticsearch start
    fi

# Asterisk
Install Asterisk. -- hint -- Consider changing the provision.sh to automatically install Asterisk if the virtual machine is destroyed and recreated.

  * This script installs Asterisk on the virtual machine and sets it up to run at startup using the `chkconfig` command.

  ## Added the Following to the provision.sh file
  # Install Asterisk
    yum install -y epel-release
    yum install -y asterisk

  # Set up Asterisk to run at startup
    chkconfig asterisk on



# Stuff
Updated the provision.sh to find more reliable repo sources... 
Edit the file `vi /etc/yum.repos.d/epel.repo`
  In the first section ([epel]):
  Comment `metalink=https://...`
  Uncomment `baseurl=http://...`