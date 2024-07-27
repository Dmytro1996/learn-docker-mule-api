FROM adoptopenjdk/openjdk8

LABEL maintainer="bibekgorain"

ENV MULE_HOME=/opt/mule

ENV MULE_VERSION=4.4.0

COPY src /usr/local/lib/learn-docker-api/src
COPY pom.xml /usr/local/lib/learn-docker-api
COPY mule-artifact.json /usr/local/lib/learn-docker-api/
COPY mule-artifact.json /usr/local/lib/learn-docker-api/META-INF/mule-artifact/

RUN apt update
RUN apt-get install unzip
#RUN apt-get install zip

RUN set -x \
&& cd /opt \
&& curl -o mule.zip https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/${MULE_VERSION}/mule-standalone-${MULE_VERSION}.zip \
&& unzip mule.zip \
&& mv mule-standalone-$MULE_VERSION mule \
&& rm mule.zip* #\
#&& zip -r /opt/mule/apps/learn-docker-api.zip /usr/local/lib/learn-docker-api

COPY /usr/local/lib/learn-docker-api /opt/mule/apps/learn-docker-api

WORKDIR $MULE_HOME

VOLUME ["$MULE_HOME/logs", "$MULE_HOME/conf", "$MULE_HOME/apps", "$MULE_HOME/domains"]

EXPOSE 8081

ENTRYPOINT ["./bin/mule"]