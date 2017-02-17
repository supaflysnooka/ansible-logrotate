# Script to gracefully restart HAProxy with 0 downtime & 1s delay on SYN requests

haproxyscript="/usr/local/sbin/haproxy"
pid="/var/run/haproxy.pid"
cfgfile="/etc/haproxy/haproxy.cfg"

/usr/bin/sudo /sbin/iptables -I INPUT -p tcp --dport 80 --syn -j DROP
/usr/bin/sudo /sbin/iptables -I INPUT -p tcp --dport 443 --syn -j DROP
  sleep 0.2
${haproxyscript} -f ${cfgfile} -p ${pid} -sf $(cat ${pid}) 
/usr/bin/sudo /sbin/iptables -D INPUT -p tcp --dport 80 --syn -j DROP
/usr/bin/sudo /sbin/iptables -D INPUT -p tcp --dport 443 --syn -j DROP
sleep 1
