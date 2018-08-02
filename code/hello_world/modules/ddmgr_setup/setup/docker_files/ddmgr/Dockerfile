FROM centos

RUN yum -y update

RUN yum install -y java-1.8.0-openjdk
RUN yum install -y iproute

RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";

ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY ./run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

EXPOSE 30000

COPY ./distributeddatamgr-0.0.1.jar /home/distributeddatamgr.jar
COPY ./lib /home/lib

ENTRYPOINT [ "/usr/bin/run.sh" ]
#CMD [ "$OWN_IP_ADDR", "$RABBIT_PORT", "$MONGO_PORT", "$OVERLAYWEAVER_PORT", "$SIENA_PORT" ]

#COPYRIGHT Fujitsu Limited 2017 and FUJITSU LABORATORIES LTD. 2017