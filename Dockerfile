# PostgreSQL 9.2

FROM fgrehm/ventriloquist-base
MAINTAINER vartana@gmail.com

RUN wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add - && \
    aptitude install debian-keyring debian-archive-keyring && \
    echo "deb http://apt.postgresql.org/pub/repos/apt sid-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y postgresql-9.2 postgresql-contrib-9.2 postgresql-plperl-9.2 p7zip-full && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    apt-get autoremove && \
    apt-get clean

ADD config /

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

RUN /bin/prepare-postgres vagrant vagrant

EXPOSE  5432
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

CMD     ["/bin/start-postgres"]
