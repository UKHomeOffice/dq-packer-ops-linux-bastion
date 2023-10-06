#!/bin/sh
# Get the instance region and inject it in the conf
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 3600"`
EC2_AVAIL_ZONE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/availability-zone)
REGION=$(ec2metadata --availability-zone | head -c-2)
sed -i -e 's/.*region.*/region = '$REGION'/' /var/awslogs/etc/aws.conf

# Restart the awslogs agent
service awslogs restart
