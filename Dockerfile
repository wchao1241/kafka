FROM neunnsy/kafka

ADD start.sh /opt/kafka/start.sh
RUN chmod +x /opt/kafka/start.sh

ENTRYPOINT ["start.sh"]
