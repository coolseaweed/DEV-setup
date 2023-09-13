#!/bin/bash

# please run via sudor (sudo -i)

BACKEND=${BACKEND:-UBUNTU} 
if [ $BACKEND == "RASP" ];then
  DOCKER_URL="https://download.docker.com/linux/raspbian"
elif [ $BACKEND == "UBUNTU" ];then
  DOCKER_URL="https://download.docker.com/linux/ubuntu"
fi

echo -e "* BACKEND: ${BACKEND}\n* DOCKER_URL: $DOCKER_URL"

apt-get update && apt-get install ca-certificates curl gnupg && \
install -m 0755 -d /etc/apt/keyrings && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg && \
chmod a+r /etc/apt/keyrings/docker.gpg  && \
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] ${DOCKER_URL} \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
apt-get update && \
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 

