FROM shykes/nodejs:latest

MAINTAINER Bhasker Kode "bosky101@gmail.com"

RUN mkdir /data /var/run/sshd

RUN apt-get install -q -y wget libssl-dev

RUN wget https://github.com/etsy/statsd/archive/v0.6.0.tar.gz --no-check-certificate
RUN tar -xvzf v0.6.0.tar.gz

ADD config.js /data/config.js
ADD Done.md /data/docker-statsd-README.md

EXPOSE 8125:8125/udp
EXPOSE 8126:8126

RUN sed -i 's/localhost/`hostname`/g' /data/config.js

RUN cat /data/config.js
RUN cat /data/docker-statsd-README.md

CMD exec node /statsd-0.6.0/stats.js /data/config.js