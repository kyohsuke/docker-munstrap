#!/bin/bash
NODES=${NODES:-}

# generate node list
for NODE in $NODES
do
    NAME=`echo $NODE | cut -d ':' -f1`
    HOST=`echo $NODE | cut -d ':' -f2`
    cat << EOF >> /etc/munin/munin.conf
[$NAME]
    address $HOST
    use_node_name yes

EOF
done

if [[ -v CAPTURE_HOST ]]
then
  NAME="host.docker"
  HOST=`netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}'`
  cat << EOF >> /etc/munin/munin.conf
[$NAME]
    address $HOST
    use_node_name yes

EOF
fi

# placeholder html to prevent permission error
cat << EOF > /var/cache/munin/www/index.html
<html>
<head>
  <title>Munin</title>
</head>
<body>
Munin has not run yet.  Please try again in a few moments.
</body>
</html>
EOF
mkdir -p /var/lib/munin
chown munin:munin /var/lib/munin
chown munin:munin /var/cache/munin/www/index.html

mkdir -p /var/lib/munin/cgi-tmp
chowm munin:www-data /var/lib/munin/cgi-tmp
chmod 775 /var/lib/munin/cgi-tmp

# start cron
/usr/sbin/cron &
# start local munin-node
/usr/sbin/munin-node > /dev/null 2>&1 &
echo "Using the following munin nodes:"
echo $NODES
# start apache
/usr/sbin/apache2ctl -DFOREGROUND
