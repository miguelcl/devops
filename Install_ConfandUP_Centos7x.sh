##KickStar en CentOS7x

#Cambiar Clave root
echo "root:aaaabbbb" | chpasswd

#### Actualizacion de Software
####
yum check-update
yes | yum update 
yes | yum install nmap
yes | yum install vim
yes | yum install bind-utils
yes | yum install iptables-services

echo 'PATH=$PATH:$HOME/bin' >> /root/.bash_profile
echo 'export PATH' >> 		 /root/.bash_profile

#### Cambiar puerto SSH al 22
sed /etc/ssh/sshd_config -i -e "s/^Port.*$/Port 22/g"
/bin/systemctl restart sshd.service

### Enable Iptables:
systemctl disable firewalld
systemctl enable iptables.service
systemctl start iptables.service

#####
# FW START
LBIN="/root/bin"
mkdir $LBIN
chmod 755 $LBIN
touch $LBIN/fw.sh
FW="$LBIN/fw.sh"
echo '###################'  >> $FW
echo '## FW SCRIPT     ##'  >> $FW
echo '###################'  >> $FW
echo 'IPT="/sbin/iptables"' >> $FW 
echo 'printf "PATH IPTABLES= $IPT"' >> $FW
echo "IFACE_WAN=$(ip route | grep src | awk '{print $3}') "  >>$FW
echo "IP_WAN=$(ip route | grep src | awk '{print $9}')     " >>$FW
echo 'ALL="0.0.0.0/0" '>>$FW
echo 'LOC="127.0.0.1" '>>$FW
echo ''>>$FW
echo '$IPT -F '>>$FW
echo '$IPT -t nat -F '>>$FW
echo '$IPT -t mangle -F '>>$FW
echo '$IPT -X '>>$FW
echo '$IPT -t nat -X '>>$FW
echo '$IPT -t mangle -X '>>$FW
echo '$IPT -Z '>>$FW
echo '$IPT -t nat -Z '>>$FW
echo '$IPT -t mangle -Z '>>$FW
echo '$IPT -P INPUT DROP '>>$FW
echo '$IPT -P FORWARD DROP '>>$FW
echo '$IPT -P OUTPUT ACCEPT '>>$FW
echo 'MP="/sbin/modprobe"' >>$FW
echo '$MP ip_conntrack_ftp && printf "\tcargando modulo: $_"	'>>$FW
echo '$MP ip_nat_ftp && printf "\n\tcargando modulo:$_" 		'>>$FW
echo '$IPT -A INPUT -i $IFACE_WAN -p tcp -m tcp --dport 22 -m state --state NEW -j ACCEPT' >>$FW
echo 'printf "ssh"'

echo '$IPT -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT'	>>$FW
echo '$IPT -A INPUT -p icmp -j ACCEPT'								>>$FW
echo 'printf "\n"'													>>$FW
echo 'service iptables save' 										>>$FW
echo 'printf "\n"'													>>$FW
chmod 755 $FW
sh $FW
##### FIN FW
##########

 systemctl list-unit-files

## PYTHON

yum -y install yum-utils
yum -y groupinstall development
yum -y install https://centos7.iuscommunity.org/ius-release.rpm
yum -y install python36u
yum -y install python36u-pip
pip3.6  install --upgrade pip

###### Cambiando de Python 2 a 3
ls -las /usr/bin/python
cd /usr/bin/
rm -rf python
ln -fs python3.6 python
######

mkdir environments
cd environments
#python3.6 -m venv my_env
#source my_env/bin/activate
