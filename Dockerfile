# solr-sunspot

FROM alexeiled/java7-maven-git
MAINTAINER Edwin Cruz <softr8@gmail.com>

RUN git clone https://github.com/ksclarke/solr-jetty-maven /opt/solr
RUN cd /opt/solr; mvn install

RUN rm /opt/solr/src/main/resources/solr/collection1/conf/schema.xml
RUN rm /opt/solr/src/main/resources/solr/collection1/conf/solrconfig.xml

ADD config/schema.xml /opt/solr/src/main/resources/solr/collection1/conf/schema.xml
ADD config/solrconfig.xml /opt/solr/src/main/resources/solr/collection1/conf/solrconfig.xml

EXPOSE 8983

CMD ["/bin/bash", "-c", "cd /opt/solr; export MAVEN_OPTS=\"-Xmx256m\" && mvn jetty:run"]
