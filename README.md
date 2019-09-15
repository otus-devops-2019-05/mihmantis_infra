# mihmantis_infra
mihmantis Infra repository

### HW8

Installed ansible. Created inventory and config files for two groups app and db.
Created playbook for downloading git repository to app server.
Because of idempotency of ansible git module, git task in playboook is completed with SUCCESS state both when reddit folder already present on app server and if it is not.

##### Extra tasks
[*] Created inventory.py script for dynamic inventory

### HW6

Files to build infrastracture using terraform were created  
main.tf - file with discription of infrastructer consisting of one VM and one firewall rule  
variables.tf - file with variables description with defult values  
terraform.tfvars - values for variables described in variables.tf  
outputs.tf - file with output values description

##### Extra tasks
Applying terraform configuration after adding ssh-key manually using GCP web interface results
in rewriting of project metadata and removing of manually added key.

### HW5

To build image reddit-base run command:
```
packer build -var-file variables.json ubuntu16.json
```

##### Extra task
To build image reddit-full using reddit-base image run command:
```
packer build -var project_id=infra-xxxxx immutable.json
```

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

