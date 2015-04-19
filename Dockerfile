FROM aiyara/debian:wheezy
MAINTAINER Chanwit Kaewkasi <chanwit@gmail.com>

RUN apt-get update && apt-get install -y openjdk-7-jre-headless wget
RUN wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.6 /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-armhf
ENV JVMFLAGS "-Xms128m -Xmx128m -server -XX:-UsePerfData -XX:+UseParNewGC -XX:MaxNewSize=128m -XX:NewSize=128m -Xms512m -Xmx512m -XX:SurvivorRatio=128 -XX:MaxTenuringThreshold=0  -XX:+UseTLAB -XX:+UseConcMarkSweepGC"
ENV JMXPORT 9010

EXPOSE 2181 2888 3888 9010

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]
COPY zkServer.sh /opt/zookeeper/bin/zkServer.sh

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
