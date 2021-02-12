#!/bin/bash

# Pass in your CyberCNS instance hostname (eg. mycompany.mycybercns.com) as the first argument
# Pass in the client site identifier as the second argument
# example: "./get-docker-container.sh mycompany.mycybercns.com 5f17172880000ffffffff"


if [[ $# -ne 2 ]]; then
    echo "ERROR: Need to pass the correct parameters. Usage: ./get-docker-container.sh <My CNS URL> <site identifier>"
    exit 2
fi

# silently quit if this a Perch Sensor is in pass-thru mode
# we've had some cases where the traffic stops passing when the container boots
(hostname | grep -qi "perch") && ifconfig bridge0 && echo "Exiting because Bridged Interface" && exit

cybercns_hostname=$1
cybercns_company_id=$2

if ! (which docker-compose); then
  echo "Docker Compose was not found on your system. Attempting to install it using standard distro utils"
  which dnf && dnf -y install podman-compose curl
  which yum && yum -y install docker docker-compose curl 
  which apt && apt-get -y install docker docker-compose curl
  if ! (which docker-compose); then 
    echo "Still unable to find docker-compose on this system. You will need to install docker-compose manually. Exiting"
    exit 100
  fi
fi

compose=$(which docker-compose)

systemctl enable docker
systemctl start docker

containerdir="/usr/local/containers/cybercns-$cybercns_site_id"
mkdir -p $containerdir/{logs,salt,minion,cache,salt/minion.d}

echo 'id: '$cybercns_site_id > $containerdir/salt/minion.d/minion.conf
echo 'master: '$cybercns_hostname >> $containerdir/salt/minion.d/minion.conf
echo '
grains_cache: True
grains_cache_expiration: 86400
random_reauth_delay: 60
recon_default: 1000
recon_max: 59000
recon_randomize: True
' >> $containerdir/salt/minion.d/minion.conf

echo """
version: "3"
services:
  cybercnsvulnerabilityagent:
    container_name: cyberCNSAgent
    privileged: true
    image: "docker.io/cybercnssaas/cybercns_agent"
    network_mode: host
    # environment:
    #   LOG_LEVEL: "debug"
    restart: always
    volumes:
      - \"$containerdir/logs:/opt/CyberCNSAgent/logs\"
      - \"$containerdir/salt:/etc/salt\"
      - \"$containerdir/minion:/var/lib/salt/pki/minion\"
      - \"$containerdir/cache:/var/cache/salt\"
""" > $containerdir/docker-compose.yaml

cd $containerdir
$compose pull
$compose up -d 




