###to build image from Docker 
git clone https://github.com/n0needt0/docker-ganglia.git
cd docker-ganglia

###build as root
sudo -s 
docker build -t n0needt0/docker-ganglia .

###setup host

##create required data directory on the host:  
##this is where ganglia data will live, so it can survive redeployments
##this is schema i use on my hosts like so /srv/doker/CONTAINER_NAME/..local dir on container..

mkdir -p /srv/docker/ganglia/var/lib/ganglia/rrds
chown -R nobody /srv/docker/ganglia/var/lib/ganglia/rrds

##other optional directories where your custom configuration files may live

### Mounted Volumes

Host              | Container                  | Notes
----------------- | -------------------------- | -------------------------------
DOCKER ASSIGNED   | /var/lib/ganglia           | ganglia data and logs
DOCKER ASSIGNED   | /etc/ganglia               | gangalia setup files
DOCKER ASSIGNED   | /etc/nginx                 | nginx setup files
DOCKER ASSIGNED   | /etc/logrotate.d           | logrotate directives
DOCKER ASSIGNED   | /var/log                   | logfiles

### Mapped Ports

Host | Container | Service
---- | --------- | ---------------------------------------------------------------------------
8484 | 80        | nginx //if you want security front this with something
8649 | 8649      | ganglia UDP port //this is where you send your data from other hosts

### Base Image

Built using [Phusion's base image](https://github.com/phusion/baseimage-docker).

### Running Ganglia

```
docker run -d --name ganglia \
--restart=always \
-v /srv/docker/ganglia/var/lib/ganglia:/var/lib/ganglia \
-v /srv/docker/ganglia/var/log:/var/log \
-p 8484:80 -p 8649:8649/udp \
n0needt0/docker-ganglia
```

###Test installation

go to http://dockerhost:8484

you should see single node, the ganglia containr itself "monitor"
after a while you should see data..

