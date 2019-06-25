# mihmantis_infra
mihmantis Infra repository

### HW4

Server addresses:
testapp_IP = 35.221.144.64
testapp_port = 9292

##### Extra task
To start application using gcloud startup script run:
```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup.sh
```

To create firewall rule for puma server run:
```
gcloud compute firewall-rules create default-puma-server3 --allow tcp:9292 \
  --direction INGRESS \
  --target-tags=puma-server
```

### HW3

#### Connecting to internal host via SSH
To create new connection to internal host in one line run the command:
```
eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa && ssh -A -t 35.210.8.70 ssh 10.132.0.3
```

##### Extra task
To connect to internal host by hostname run command (it will add ssh configuration for someinternalhost host)
```
cat <<EOF >> ~/.ssh/config
Host bastion
  HostName 35.210.8.70

Host someinternalhost
  ProxyCommand ssh -q bastion nc -q0 10.132.0.3 22
EOF
```

#### Using VPN to connect to internal host

Server addresses:
bastion_IP = 35.210.8.70
someinternalhost_IP = 10.132.0.3

##### Extra task
Access with valid Let's encrypt certificate using address:
https://35.210.8.70.sslip.io

