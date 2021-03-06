#!/bin/bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org

sudo rm /etc/mongod.conf
sudo cp /home/ubuntu/app/box_db/templates/mongod.conf /etc/mongod.conf

cd /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start mongod
sudo systemctl enable mongod