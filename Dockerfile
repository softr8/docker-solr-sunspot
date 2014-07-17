# solr-sunspot

FROM jhamit/maven
MAINTAINER Derek Kastner <dkastner@gmail.com>
MAINTAINER Edwin Cruz <softr8@gmail.com>

RUN apt-get update
RUN apt-get --yes install git

RUN git clone https://github.com/ksclarke/solr-jetty-maven /opt/solr
RUN cd /opt/solr; mvn install

ADD config/schema.xml /opt/solr/src/main/resources/solr/collection1/conf/schema.xml
ADD config/solrconfig.xml /opt/solr/src/main/resources/solr/collection1/conf/solrconfig.xml

ADD config/schema.xml /opt/solr/src/main/resources/solr/default/conf/schema.xml
ADD config/solrconfig.xml /opt/solr/src/main/resources/solr/default/conf/solrconfig.xml

EXPOSE 8983

CMD ["/bin/bash", "-c", "cd /opt/solr; export MAVEN_OPTS="-Xmx256m" && mvn jetty:run "]
