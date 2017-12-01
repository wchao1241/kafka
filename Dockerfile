
FROM openjdk:8u102-jre

ENV kafka_version=0.10.1.1
ENV scala_version=2.11.8
ENV kafka_bin_version=2.11-$kafka_version

RUN curl -SLs "http://www.scala-lang.org/files/archive/scala-$scala_version.deb" -o scala.deb \
	&& dpkg -i scala.deb \
	&& rm scala.deb \
	&& curl -SLs "http://www.apache.org/dist/kafka/$kafka_version/kafka_$kafka_bin_version.tgz" | tar -xzf - -C /opt \
	&& mv /opt/kafka_$kafka_bin_version /opt/kafka

COPY start.sh /opt/kafka/start.sh
RUN chmod +x /opt/kafka/start.sh
	
WORKDIR /opt/kafka

ADD config/server.properties config/
ADD config/kafka-connect-elasticsearch/* libs/
ADD config/connect-distributed.properties config/
#CMD ["config/server.properties"]
ENTRYPOINT ["start.sh"]