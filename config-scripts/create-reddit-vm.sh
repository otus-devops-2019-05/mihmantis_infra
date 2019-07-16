#!/bin/bash

gcloud compute instances create reddit-app --boot-disk-size 20G --image-family reddit-full --machine-type f1-micro --tags puma-server

