#!/bin/bash
#
#
################################
#
# SCRIPT INSTALACION JENKINS
# S.O: Centos 7.x / RHEL 7.X
# Autor: Miguel Amador @miguelcl 
#
#
################################



URL_JENK="http://internal.repo/core/jenkins/"
URL_PROXY="http://user:pass@proxy.internal.repo:8080"

####### Descarga de informacion de repos y key
# rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

curl -O  /etc/yum.repos.d/jenkins.repo  $URL_JENK/jenkins.repo
rpm --import 							$URL_JENK/jenkins-ci.org.key

### if exist proxy set global proxy setting.
export http_proxy=$URL_PROXY

### Instalacion jenkins from rpm
yum install java
yum install jenkins

/sbin/chkconfig jenkins on

systemctl status jenkins.service
systemctl stop jenkins.service
systemctl start jenkins.service

netstat -putan | grep jenkins
