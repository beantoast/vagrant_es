#!/bin/bash
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y software-properties-common debconf-utils
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
#echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
#sudo apt-get install -y oracle-java8-installer
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list

sudo apt-get update && sudo apt-get install elasticsearch
sudo sed -i -r 's/^#?\s?network\.host:\s?[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/network.host: 0.0.0.0/g' /etc/elasticsearch/elasticsearch.yml
sudo sed -i -r 's/-Xms[0-9]+(m|g)/-Xms512m/g' /etc/elasticsearch/jvm.options
sudo sed -i -r 's/-Xmx[0-9]+(m|g)/-Xmx512m/g' /etc/elasticsearch/jvm.options
sudo /bin/systemctl daemon-reload 
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch

sudo apt-get update && sudo apt-get install kibana
sudo sed -i -r 's/^#?\s?server\.host:\s?([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}|"localhost")/server.host: 0.0.0.0/g' /etc/kibana/kibana.yml
sudo /bin/systemctl daemon-reload 
sudo /bin/systemctl enable kibana.service
sudo /bin/systemctl start kibana

sudo apt-get update && sudo apt-get install logstash
sudo sed -i -r 's/-Xms[0-9]+(m|g)/-Xms256m/g' /etc/logstash/jvm.options
sudo sed -i -r 's/-Xmx[0-9]+(m|g)/-Xmx256m/g' /etc/logstash/jvm.options
sudo apt-get install -y logstash
#sudo /bin/systemctl daemon-reload 
#sudo /bin/systemctl enable logstash.service
#sudo /bin/systemctl start logstash