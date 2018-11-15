#!/bin/bash
gcloud compute instances create $1 --boot-disk-size=20GB --image=reddit-full --image-project=silver-osprey-219908 --machine-type=g1-small --tags puma-server --restart-on-failure