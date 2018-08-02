/usr/local/bin/docker-compose -f ddmgr_setup/setup/docker_compose/ddmgr_index/docker-compose.yml down
rm -rf ddmgr_setup/setup/docker_files/ddmgr/lib/

/usr/local/bin/docker-compose -f sink-agent_setup/setup/docker_compose/sink-agent/docker-compose.yml down
rm -rf sink-agent_setup/setup/docker_files/sink-agent/WEB-INF/lib/

#COPYRIGHT Fujitsu Limited 2017 and FUJITSU LABORATORIES LTD. 2017
