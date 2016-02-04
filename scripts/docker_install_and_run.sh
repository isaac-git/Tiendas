#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo docker pull lorenmanu/submodulo-lorenzo
sudo docker run -t -i lorenmanu/submodulo-lorenzo /bin/bash
