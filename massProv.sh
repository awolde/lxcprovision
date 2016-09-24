lxc launch chef-ready-centos6 $1
lxc file push chef-12.5.1-1.el6.x86_64.rpm $1/root/
lxc exec $1 -- /bin/sh -c "rpm -ivh chef-12.5.1-1.el6.x86_64.rpm"
sleep 4
IP=`lxc info $1 | grep eth0 | cut -f3`
echo "IP address of $1: $IP"
knife bootstrap $IP --ssh-password 123
knife node run_list add $1 "recipe[init]"
knife node run_list add $1 "recipe[random-app]"
lxc exec $1 chef-client
lxc exec $1 -- /bin/sh -c "adduser -g wheel $1 -p \$6\$t6HutDgc\$A3525.6nVGj1uui6zbILnld5RQ6NASbGwSNl4disDg62cabT7ycafU.hRIFQGgQl57spepb8qiGA5sE600VcX."
lxc exec $1 -- /bin/sh -c "rm /etc/ssh/sshd_config"
lxc file push sshd_config $1/etc/ssh/sshd_config
lxc exec $1 -- /bin/sh -c "echo Port $2 >> /etc/ssh/sshd_config"
lxc exec $1 -- /bin/sh -c "service sshd restart"
RED='\033[0;31m'
echo -e "${RED} $1 == $IP == $2"
