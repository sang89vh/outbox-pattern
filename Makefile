.ONESHELL: build start setup application test monitor stop
build:
	cd custom-debezium-transformer;
	mvn clean install
	sudo docker build -t custom-debezium-connect .
start:
	sudo docker-compose up
setup:
	sudo docker exec -t kafka /usr/bin/kafka-topics \
		  --create --bootstrap-server :9092 \
		  --topic student_email_changed \
		  --partitions 1 \
		  --replication-factor 1

	sudo docker exec -t kafka /usr/bin/kafka-topics \
		  --create --bootstrap-server :9092 \
		  --topic student_enrolled \
		  --partitions 1 \
		  --replication-factor 1

	curl -X POST \
      http://localhost:8083/connectors/ \
      -H 'content-type: application/json' \
      -d '{"name":"student-outbox-connector","config":{"connector.class":"io.debezium.connector.postgresql.PostgresConnector","tasks.max":"1","database.hostname":"postgres","database.port":"5432","database.user":"user","database.password":"password","database.dbname":"studentdb","database.server.name":"pg-outbox-server","tombstones.on.delete":"false","table.whitelist":"public.outbox","transforms":"outbox","transforms.outbox.type":"com.sohan.transform.CustomTransformation"}}'


application:
	cd student-microservice;
	mvn spring-boot:run
test:
	curl -X POST \
	  'http://localhost:8080/students/~/enroll' \
	  -H 'content-type: application/json' \
	  -d '{"name": "Megan Clark","email": "mclark@gmail.com","address": "Toronto, ON"}'

	curl -X PUT \
	  'http://localhost:8080/students/1/update-email' \
	  -H 'content-type: application/json' \
	  -d '{"email": "jsmith@gmail.com"}'

monitor:
	firefox  http://localhost:8080/topics
stop:
	sudo docker-compose down
	./stopContainers.sh