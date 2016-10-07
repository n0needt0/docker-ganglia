#!/bin/bash
mkdir -p /var/lib/ganglia/rrds
chown -R nobody /var/lib/ganglia/rrds
chown -R nobody /var/log
usermod -aG www-data nobody

echo "Ganglia Ready"