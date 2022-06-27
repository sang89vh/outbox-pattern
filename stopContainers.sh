echo -e "\nStopping containers ....."
sudo docker stop $(docker ps -a | grep postgres | cut -d ' ' -f 1)
sudo docker stop $(docker ps -a | grep kafka | cut -d ' ' -f 1)
sudo docker stop $(docker ps -a | grep zookeeper | cut -d ' ' -f 1)
sudo docker stop $(docker ps -a | grep connect | cut -d ' ' -f 1)
sudo docker rm postgres
sudo docker rm kafka
sudo docker rm zookeeper
sudo docker rm debezium-connect
echo -e "\nAll Containers stopped."

