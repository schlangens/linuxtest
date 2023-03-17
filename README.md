# Completed solution

## Installation

* Make sure you have already installed [Vagrant](https://www.vagrantup.com/)
* Clone this project to your own machine
* after first `vagrant up` command you many need to edit the repo file to get http to work properly

## Setup

`vagrant up`

## Once the server is online in virtualbox

`vagrant ssh`

`sudo vi /etc/yum.repos.d/epel.repo`

 - Comment `metalink=https://...`
 - Uncomment `baseurl=http://...`
 
 

