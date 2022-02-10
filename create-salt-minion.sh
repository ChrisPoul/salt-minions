sudo apt update
sudo apt-get install python3 salt-common vim -y
sudo apt-get install salt-minion -y

echo "master: master's ip goes here" | sudo tee /etc/salt/minion
echo "master_finger: 'master.pub key goes here'" | sudo tee -a /etc/salt/minion
sudo systemctl restart salt-minion