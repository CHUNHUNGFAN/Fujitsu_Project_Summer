cd ddmgr_setup/
mvn dependency:copy-dependencies -DoutputDirectory=./setup/docker_files/ddmgr/lib
cp ../config.properties setup/docker_compose/ddmgr_index/config_index/config.properties
docker build -t distributeddatamgr setup/docker_files/ddmgr/
docker build -t rabbitmq setup/docker_files/rabbitmq/

/usr/local/bin/docker-compose -f setup/docker_compose/ddmgr_index/docker-compose.yml up -d

cd ../sink-agent_setup/
mvn dependency:copy-dependencies -DoutputDirectory=./setup/docker_files/sink-agent/WEB-INF/lib
docker build -t sink-agent setup/docker_files/sink-agent/

/usr/local/bin/docker-compose -f setup/docker_compose/sink-agent/docker-compose.yml up -d


#COPYRIGHT Fujitsu Limited 2017 and FUJITSU LABORATORIES LTD. 2017
